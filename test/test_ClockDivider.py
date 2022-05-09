import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles


# test the default case, with reg len set to 8, so 128 cycles of off then 128 cycles of on
@cocotb.test()
async def test_ClockDivider(dut):
    
    clock = Clock(dut.clk, 10, units="us")
    cocotb.fork(clock.start())

    dut.rst.value = 1
    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0

    # repeat 4 times
    for j in range(4):

        # starts low
        for i in range(128):
            await ClockCycles(dut.clk, 1)
            assert(dut.out == 0)

        # goes high
        for i in range(128):
            await ClockCycles(dut.clk, 1)
            assert(dut.out == 1)
