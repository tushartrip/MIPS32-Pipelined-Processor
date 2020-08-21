`timescale 1ns/1ns
module MIPS32_TB;
reg clk1,clk2;
integer k,i;

MIPS32 myproc (clk1,clk2);
	
	initial
	begin
		clk1=0; 
		clk2=0;
	end

	always
	begin	
		#5 clk1=1; #5 clk1=0;
		#5 clk2=1; #5 clk2=0;
	end


	initial
	begin
		for (k=0;k<31;k=k+1)
			myproc.Reg[k]=k;
			
//		myproc.mem[0]=32'h2801000a;   //ADDI R1,R0,10
//		myproc.mem[1]=32'h28020014;   //ADDI R2,R0,20
//		myproc.mem[2]=32'h28030019;   //ADDI R3,R0,25
//		myproc.mem[3]=32'h0ce77800;   //OR   R7,R7,R7  DUMMY
//		myproc.mem[4]=32'h0ce77800;   //OR   R7,R7,R7  DUMMY
//		myproc.mem[5]=32'h00222000;   //ADD  R4,R1,R2
//		myproc.mem[6]=32'h0ce77800;   //OR   R7,R7,R7  DUMMY
//		myproc.mem[7]=32'h00832800;   //ADD  R5,R4,R3
//		myproc.mem[8]=32'hfc000000;   //HLT
		
		myproc.mem[0]=32'h280a00c8;   //ADDI R10,R0,200
		myproc.mem[1]=32'h28020001;   //ADDI R2,R0,1
		myproc.mem[2]=32'h0e94a000;   //OR R20,R20,R20 DUMMY
		myproc.mem[3]=32'h21430000;   //LW  R3,0(R10)
		myproc.mem[4]=32'h0e94a000;   //OR R20,R20,R20 DUMMY
		myproc.mem[5]=32'h14431000;   //LOOP: MUL R2,R2,R3
		myproc.mem[6]=32'h2c630001;   //SUBI R3,R3,1
		myproc.mem[7]=32'h0e94a000;   //OR R20,R20,R20 DUMMY
		myproc.mem[8]=32'h3460fffc;   //BNEQZ R3, LOOP  (Offset -4)
		myproc.mem[9]=32'h2542fffe;	//SW R2, -2(R10)
		myproc.mem[10]=32'hfc000000;	//HLT
		
		myproc.mem[200]=7;
		
		myproc.HALTED      =0;
		myproc.PC          =0;
		myproc.TAKEN_BRANCH0=1;

		#900 $display($time,"Mem[200]=%2d Mem[198]=%6d", myproc.mem[200],myproc.mem[198]);
		
	end
		
	initial
	begin
		$monitor($time, "R2: %4d ",myproc.Reg[2]);
	end
	

endmodule 
		
		
		