# COCOTB variables
export COCOTB_REDUCED_LOG_FMT=1
export PYTHONPATH := test:$(PYTHONPATH)
export LIBPYTHON_LOC=$(shell cocotb-config --libpython)

all: test_ClockDivider test_HexSevenSegmentDecoder test_PrimitiveCalculator test_Debouncer test_PrimitiveALU test_RotaryEncoder

# if you run rules with NOASSERT=1 it will set PYTHONOPTIMIZE, which turns off assertions in the tests
test_PrimitiveCalculator:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s PrimitiveCalculator -s dump -g2012 src/PrimitiveCalculator.v test/dump_PrimitiveCalculator.v src/ src/ClockDivider.v src/HexSevenSegmentDecoder.v src/Debouncer.v src/PrimitiveALU.v src/RotaryEncoder.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_PrimitiveCalculator vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_ClockDivider:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s ClockDivider -s dump -g2012 test/dump_ClockDivider.v src/ClockDivider.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_ClockDivider vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_HexSevenSegmentDecoder:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s HexSevenSegmentDecoder -s dump -g2012 src/HexSevenSegmentDecoder.v test/dump_HexSevenSegmentDecoder.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_HexSevenSegmentDecoder vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_Debouncer:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s Debouncer -s dump -g2012 src/Debouncer.v test/dump_Debouncer.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_Debouncer vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_PrimitiveALU:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s PrimitiveALU -s dump -g2012 src/PrimitiveALU.v test/dump_PrimitiveALU.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_PrimitiveALU vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

test_RotaryEncoder:
	rm -rf sim_build/
	mkdir sim_build/
	iverilog -o sim_build/sim.vvp -s RotaryEncoder -s dump -g2012 src/RotaryEncoder.v test/dump_RotaryEncoder.v
	PYTHONOPTIMIZE=${NOASSERT} MODULE=test.test_RotaryEncoder vvp -M $$(cocotb-config --prefix)/cocotb/libs -m libcocotbvpi_icarus sim_build/sim.vvp
	! grep failure results.xml

show_%: %.vcd %.gtkw
	gtkwave $^
