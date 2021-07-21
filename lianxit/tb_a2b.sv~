`timescale 1ps/1ps
module tb_a2b;
    logic clka;
    logic clkb;
    logic pulse_a;
    logic pulse_b;
    logic rstn;

    a2b dut(
        .clka(clka),
        .clkb(clkb),
        .pulse_a(pulse_a),
        .pulse_b(pulse_b),
        .rstn(rstn)
    );

    initial begin
        clka = 0;
        clkb = 0;
        fork
            forever #10 clka = ~clka;
            forever #30 clkb = ~clkb;
        join
    end

    task apulse_gen();
        pulse_a <= 1;
        @(posedge clka);
        pulse_a <= 0;
        @(posedge clka);
    endtask

    initial begin
        rstn = 0;
        pulse_a = 0;
        #100
        rstn <= 1;
        @(posedge clka);
        apulse_gen();
        repeat(10) @(posedge clka);
        apulse_gen();
        repeat(10) @(posedge clka);
        $stop();
    end

endmodule
