#include "Vbus_arbiter_with_rom_tb.h"
#include "verilated.h"
#include "verilated_vcd_c.h"
#include <iostream>

int main(int argc, char **argv)
{
    Verilated::commandArgs(argc, argv);

    Vbus_arbiter_with_rom_tb* mod = new Vbus_arbiter_with_rom_tb;

    Verilated::traceEverOn(true);
    VerilatedVcdC* tfp = new VerilatedVcdC;
    vluint64_t hcycle;
    int result = 0;

    mod->trace(tfp, 99);
    mod->p_reset = 1;
    tfp->open("bus_arbiter_with_rom.vcd");

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
