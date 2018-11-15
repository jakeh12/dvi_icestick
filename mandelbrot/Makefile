all:
	@verilator -Wall -trace --cc mandelbrot.v --exe mandelbrot_sim.cpp
	@make -s -j -C obj_dir -f Vmandelbrot.mk Vmandelbrot
	obj_dir/Vmandelbrot

clean:
	rm -rf obj_dir
	rm trace.vcd
