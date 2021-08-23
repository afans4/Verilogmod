`timescale 1ps/1ps
//  Module: text

class A;
    string name;
    function new();
        this.name = "A";
    endfunction
    virtual function void display();
        $display("name value is %s", name);
    endfunction
endclass

class B extends A;
    function new();
        super.new();
    endfunction //new()
endclass //B extends A

module text;
    initial begin
        A a0,a1;
        B b0,b1;
        a0 = new();
        a0.display();
        b0 = new();
        b0.display();
        b0.name = "B";
        b1 = b0;
        b1.display();
        $cast(a1,b0);
        a1.display();
        $finish();
    end
endmodule: text
