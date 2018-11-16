#include "Vmandelbrot.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <time.h>
#include <stdio.h>
#include <math.h>

float fp_fr(int fr)
{
  float sum= 0.0;
  int i;
  for (i = 0; i < 12; i++)
  {
    sum += ((fr >> (12-i)) & 0x1)*pow(2, -i);
  }
  return sum;
}

void print_fp(int fp)
{
  int units = fp >> 12 & 0x7;
  int negative = (fp >> 15 & 0x1)*-8;
  printf("%f", (float)(units + negative) + fp_fr(fp & 0x0FFF));
}

int main(int argc, char **argv)
{
	// pass command line args into verilator
	Verilated::commandArgs(argc, argv);
	
	// create instance of the translated verilog module
	Vmandelbrot* m = new Vmandelbrot;
	
	// enable and set up trace
	Verilated::traceEverOn(true);
	VerilatedVcdC* tfp = new VerilatedVcdC;	
	m->trace(tfp, 99);
	tfp->open("trace.vcd");
	
	printf("simulation has started...\n");
	clock_t begin = clock();
	
	for (int i = 0; i < 256*8; i++)
	{
	  // generate rstn
	  if (i < 2)
	    {
	      m->i_rstn = 0;
	    }
	  else
	    {
	      m->i_rstn = 1;
	    }
	  
	        // set inputs
		m->i_x = 16384;
		m->i_y = 6672;
		m->i_cx = 2313;
		m->i_cy = -232;
		m->i_cnt = 0;
		// posedge clock
		m->i_clk = 1;
		m->eval();
		tfp->dump(i*10);
		
		printf("i_x:\t");
		print_fp(m->i_x); 
		printf("\n");
		printf("i_y:\t");
		print_fp(m->i_y);
		printf("\n");
		printf("i_cx:\t");
		print_fp(m->i_cx);
		printf("\n");
		printf("i_cy:\t");
		print_fp(m->i_cy);
		printf("\n");
		printf("o_x:\t");
		print_fp(m->o_x);
		printf("\n");
		printf("o_y:\t");
		print_fp(m->o_y);
		printf("\n\n");
		
		// negedge clock
		m->i_clk = 0;
		m->eval();
		tfp->dump(i*10+5);
	}
	
	clock_t end = clock();
	double time_spent = (double)(end - begin) / CLOCKS_PER_SEC;
	
	printf("simulation finished in %f seconds!\n", time_spent);
	tfp->close();
	delete tfp;
	delete m;
	return 0;
}

