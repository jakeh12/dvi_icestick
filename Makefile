all:
	mkdir -p build
	yosys  -q -p "synth_ice40 -top top -blif build/top.blif" top.v tmds_vo/tmds_vo.v tmds_encoder/tmds_encoder.v tmds_serializer/tmds_serializer.v clk_divider/clk_divider.v timing_generator/timing_generator.v image_generator/image_generator.v character_generator/character_generator.v mandelbrot/mandelbrot.v
	arachne-pnr -d 1k -o build/top.asc -p top.pcf build/top.blif
	icepack build/top.asc build/top.bin
	icetime -d hx1k -mt build/top.asc
	
prog:
	iceprog build/top.bin
	
clean:
	rm -rf build
	
