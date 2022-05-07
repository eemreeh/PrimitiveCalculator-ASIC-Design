module dump();
    initial begin
        $dumpfile ("PrimitiveALU.vcd");
        $dumpvars (0, PriimitiveALU);
        #1;
    end
endmodule
