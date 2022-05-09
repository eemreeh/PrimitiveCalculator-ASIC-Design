import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, ReadWrite
import random

async def reset(dut):
    dut.rst.value = 1
    dut.in_a.value = 0
    dut.in_b.value = 0
    dut.select.value = 0

    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 5)

@cocotb.test()
async def test_PrimitiveALU(dut):
    clock = Clock(dut.clk, 5, units="us")
    cocotb.fork(clock.start())

    await reset(dut)
    assert dut.out.value == 0

    random_a = random.randint(0,255)
    random_b = random.randint(0,255)

    dut.load.value = 1
    dut.in_a.value = random_a
    dut.in_b.value = random_b
    await ClockCycles(dut.clk,2)
    
    # ADD
    dut.select.value = 0
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    if (random_a + random_b >=256):
        add_value = random_a + random_b - 256
    assert dut.out.value == add_value
    assert dut.flag.value == ((random_a + random_b) >= 256)

    # SUB
    dut.select.value = 1
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.flag.value == (random_a > random_b)
    assert dut.out.value == random_a - random_b

    # MUL
    dut.select.value = 2
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == random_a * random_b
    
    # DIV
    dut.select.value = 3
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == int(random_a / random_b)

    # AND
    dut.select.value = 4
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == random_a & random_b


    # OR
    dut.select.value = 5
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == random_a | random_b

    # XOR
    dut.select.value = 6
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == random_a ^ random_b

    # NOT
    dut.select.value = 7
    await ReadWrite()
    await ClockCycles(dut.clk,2)
    assert dut.out.value == ~random_a


