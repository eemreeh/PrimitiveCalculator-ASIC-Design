import cocotb
from cocotb.triggers import Timer


@cocotb.test()
async def test_ClockDivider(dut):
    dut.rst.value = 1
    await Timer(3, units="ns")
    
    for cycle in range(20):
        dut.clk.value = 0
        await Timer(1, units="ns")
        dut.clk.value = 1
        await Timer(1, units="ns")
