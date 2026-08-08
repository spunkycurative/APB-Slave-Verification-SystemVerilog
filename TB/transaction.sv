`timescale 1ns/1ps
class transaction;
  rand bit [31:0] paddr;
  rand bit [7:0] pwdata;
  //rand bit psel;
  //rand bit penable;
  randc bit pwrite;
  bit [7:0] prdata;
  bit pready;
  bit pslverr;
  
  bit random_mode=1;
  
  constraint addr_c{
  paddr>=0 ; paddr<=15;
  }
  
  constraint data_c{
  pwdata>=0 ; pwdata<=255;
  }
  
  function void display(input string tag);
        $display("[%0s] :  paddr:%0d  pwdata:%0d pwrite:%0b  prdata:%0d pslverr:%0b @ %0t",tag,paddr,pwdata, pwrite, prdata, pslverr,$time);
  endfunction
  
  endclass
