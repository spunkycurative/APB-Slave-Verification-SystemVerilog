interface apb_if;
   logic pclk,presetn, psel, penable, pwrite;
   logic [31:0] paddr;
   logic [7:0]  pwdata;
   logic [7:0]  prdata;
   logic pready, pslverr;
  
endinterface
