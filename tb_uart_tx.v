```verilog
`timescale 1ns/1ps

module tb_uart_tx;

    reg clk;
    reg rst;
    reg tx_start;
    reg [7:0] data_in;
    wire tx;
    wire busy;

    // Instantiate UART transmitter
    uart_tx uut(
        .clk(clk),
        .rst(rst),
        .tx_start(tx_start),
        .data_in(data_in),
        .tx(tx),
        .busy(busy)
    );

    // Generate 100 MHz clock (10 ns period)
    always #5 clk = ~clk;

    initial begin
        clk = 0;
        rst = 1;
        tx_start = 0;
        data_in = 8'h00;

        #100;  // Wait for reset
        rst = 0;

        #50;
        data_in = 8'hA5;  // Data to transmit
        tx_start = 1;

        #10;  // Keep tx_start high for one clock cycle
        tx_start = 0;

        // Wait until transmission is complete
        wait (busy == 0);

        #100;
        $finish;
    end

endmodule
```