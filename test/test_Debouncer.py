import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles
import random

class BouncingSwitch():

    def __init__(self, dut):
        self.dut = dut

    async def set(self, value, bounce_cycles = 5):
        for i in range(bounce_cycles):
            self.dut.in_a.value = random.randint(0, 1)
            await ClockCycles(self.dut.clk, 1)

        # finally set to what it should be
        self.dut.in_a.value = value
        await ClockCycles(self.dut.clk, 1)


async def reset(dut):
    dut.rst.value = 1
    dut.in_a.value = 0

    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 5)

@cocotb.test()
async def test_Debouncer(dut):
    clock = Clock(dut.clk, 10, units="us")
    clocks_per_phase = 10
    switch = BouncingSwitch(dut)
    cocotb.fork(clock.start())

    await reset(dut)
    assert dut.out.value == 0

    # toggle button 10 times
    for i in range(10):
        # set the switch, which will bounce
        await switch.set(1)

        # assert still low
        assert dut.out.value == 0

        # wait 8 clock cycles (default history length in Debouncer.v) + 1 for register
        await ClockCycles(dut.clk,9) 

        # assert button is as set
        assert dut.out.value == 1

        # same for off
        await switch.set(0)

        # assert still high
        assert dut.out.value == 1

        # wait 8 clock cycles (default history length in Debouncer.v) + 1 for register
        await ClockCycles(dut.clk, 9)

        assert dut.out.value == 0