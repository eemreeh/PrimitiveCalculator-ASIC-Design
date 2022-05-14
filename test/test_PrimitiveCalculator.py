import cocotb
from cocotb.clock import Clock
from cocotb.triggers import RisingEdge, FallingEdge, ClockCycles, ReadWrite
import random
from encoder import Encoder_calc

async def reset(dut):
    dut.rst.value = 1
    dut.select.value = 0
    dut.restart.value = 0
    dut.rotary_a.value = 0
    dut.rotary_b.value = 0

    await ClockCycles(dut.clk, 5)
    dut.rst.value = 0
    await ClockCycles(dut.clk, 5)

@cocotb.test()
async def test_PrimitiveCalculator(dut):
    clock = Clock(dut.clk, 5, units="us")
    clocks_per_phase = 5
    # no noise
    encoder = Encoder_calc(dut.clk, dut.rotary_a, dut.rotary_b, clocks_per_phase = clocks_per_phase, noise_cycles = 0)
    cocotb.fork(clock.start())
    
    await reset(dut)
    assert dut.seven_segment_out.value == 63
    
#    random_a = random.randint(0,255)
#    random_b = random.randint(0,255)

    random_a = 21
    random_b = 12
    
    # Start State
    dut.select.value = 1
    await ClockCycles(dut.clk, 10)
    dut.select.value = 0
    await ClockCycles(dut.clk, 3)
    
    # First Input State
    for i in range (clocks_per_phase * 2 * random_a):
        await encoder.update(1)

    dut.select.value = 1
    await ClockCycles(dut.clk, 10)
    dut.select.value = 0
    await ClockCycles(dut.clk, 3)        
    
#    await ClockCycles(dut.clk, 100)
    # Second Input State
    for i in range (random_a - random_b):
        await encoder.update(-1)

    dut.select.value = 1
    await ClockCycles(dut.clk, 10)
    dut.select.value = 0
    await ClockCycles(dut.clk, 3)  
    
    # Selection State for addition
    for i in range (12):
        await encoder.update(-1)

    dut.select.value = 1
    await ClockCycles(dut.clk, 10)
    dut.select.value = 0
    await ClockCycles(dut.clk, 3)  
    
    # Final State
    await ClockCycles(dut.clk, 3)
    if (dut.seven_segment_digit.value == 0):
        assert (dut.seven_segment_out.value == 6)
    else: 
        assert (dut.seven_segment_out.value == 91)
        
    
    

    
