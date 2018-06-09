#include "Vcontrol_status_registers_tb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);

    Vcontrol_status_registers_tb *mod = new Vcontrol_status_registers_tb;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    vluint64_t hcycle;
    int result = 0;

    mod->trace(tfp, 99);
    tfp->open("control_status_registers.vcd");

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
