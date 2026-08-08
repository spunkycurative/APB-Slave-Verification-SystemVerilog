class monitor;
       
       virtual apb_if vif;
       transaction tr;
       mailbox #(transaction)mbx;
       
       function new(mailbox #(transaction)mbx);
         this.mbx=mbx;
       endfunction
       
       task run();
         //tr=new();
         forever begin
           tr=new();
           @(posedge vif.pclk);
           if(vif.pready)
             begin
               tr.pwdata=vif.pwdata;
               tr.paddr=vif.paddr;
               tr.pwrite=vif.pwrite;
               tr.prdata=vif.prdata;
               tr.pslverr=vif.pslverr;
               @(posedge vif.pclk);
               tr.display("MON");
               mbx.put(tr);
             end
            end
         
       endtask
       
     endclass
