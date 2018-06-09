#include "Vdummy_arbiter_tb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);

    Vdummy_arbiter_tb* mod = new Vdummy_arbiter_tb;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    vluint64_t hcycle;
    int result = 0;

    mod->trace(tfp, 99);
    tfp->open("dummy_arbiter.vcd");

    while(!Verilated::gotFinish())
    {
        hcycle++;
        mod->m_clock = mod->m_clock ? 0 : 1;
        mod->eval();
        tfp->dump(hcycle * 10);
        if(mod->error)
        {
            result = mod->error_num;
            goto finish;
        }
    }
finish:
    tfp->close();
    delete mod;
    return result;
}
