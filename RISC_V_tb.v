module RISC_V_tb;

parameter clk_prd = 6 ; 
parameter WIDTH = 4 ;
reg clk_tb = 0 ;
always #(clk_prd/2) clk_tb=~clk_tb;

reg areset_tb;

RISK risk(
    .clk(clk_tb),
    .areset(areset_tb)
);

integer i ;
task reset (); begin
  for (i=0  ;i<33 ;i=i+1 ) begin
    areset_tb = 1;
    #(clk_prd/2);
    areset_tb = 0;
    #(clk_prd/2);
  end
  areset_tb = 1;
  #(clk_prd);
end
endtask

initial begin
    reset();
    #(100*clk_prd);
    $stop;
end

endmodule