
//module bootrom(p_reset, m_clock, address, in_data, out_data, load, store);
module bootrom(p_reset, m_clock, address, out_data, load, in_data, store);
    input wire p_reset, m_clock;
    input wire [31:0] address;
    input wire load;
    input wire store;
    input wire [7:0] in_data;
    output wire [31:0] out_data;

    reg [7:0] mem [0:9215];
    initial $readmemh("../hexs/led.hex", mem);

    always @(posedge m_clock, negedge p_reset)
    begin
        if(store)
        begin
            mem[address] <= in_data;
        end
    end

    assign out_data = {mem[address + 3], mem[address + 2],
                        mem[address + 1], mem[address + 0]};

endmodule
