all:
	verilator -Wall -trace --cc character_generator.v --exe character_generator_tb.cpp
	make -j -C obj_dir -f Vcharacter_generator.mk Vcharacter_generator
	obj_dir/Vcharacter_generator
	