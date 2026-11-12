```verilog
`timescale 1ns/1ps

module uart_tx(
    input wire clk,          // System clock
    input wire rst,          // Asynchronous reset signal
    input wire tx_start,     // Start transmission
    input wire [7:0] data_in,// Data to be transmitted
    output reg tx,           // UART transmission signal
    output reg busy          // Transmission busy flag
);

    // State definitions
    parameter IDLE  = 3'b000;
    parameter START = 3'b001;
    parameter DATA  = 3'b010;
    parameter STOP  = 3'b011;
    parameter DONE  = 3'b100;

    reg [2:0] state;
    reg [3:0] bit_cnt;       // Data bit counter
    reg [7:0] shift_reg;     // Transmit data register
    reg [3:0] baud_cnt;      // Controls transmission interval
                             // (Assuming 16 clock cycles per bit)

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;      // TX idle state is HIGH
            busy <= 0;
            bit_cnt <= 0;
            shift_reg <= 0;
            baud_cnt <= 0;

        end else begin
            case (state)

                IDLE: begin
                    tx <= 1'b1;
                    busy <= 0;

                    if (tx_start) begin
                        shift_reg <= data_in;
                        state <= START;
                        busy <= 1;
                        baud_cnt <= 0;
                    end
                end

                START: begin
                    tx <= 1'b0;

                    if (baud_cnt == 15) begin
                        baud_cnt <= 0;
                        bit_cnt <= 0;
                        state <= DATA;
                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                DATA: begin
                    tx <= shift_reg[bit_cnt];

                    if (baud_cnt == 15) begin
                        baud_cnt <= 0;

                        if (bit_cnt == 7)
                            state <= STOP;
                        else
                            bit_cnt <= bit_cnt + 1;

                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                STOP: begin
                    tx <= 1'b1;

                    if (baud_cnt == 15) begin
                        baud_cnt <= 0;
                        state <= DONE;
                    end else begin
                        baud_cnt <= baud_cnt + 1;
                    end
                end

                DONE: begin
                    state <= IDLE;
                end

                default: state <= IDLE;

            endcase
        end
    end

endmodule
```