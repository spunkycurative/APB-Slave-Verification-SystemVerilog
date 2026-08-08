class environment;
   
   generator gen;
   driver drv;
   monitor mon;
   scoreboard sco;
  
   event nextgd;
   event nextgs;
   
   mailbox #(transaction) mbxgd,mbxms;
   
   virtual apb_if vif;
   
   function new(virtual apb_if vif);
     mbxgd=new();
     
     gen=new(mbxgd);
     drv=new(mbxgd);
     
     mbxms=new();
     mon=new(mbxms);
     sco=new(mbxms);
     
     this.vif=vif;
     drv.vif=this.vif;
     mon.vif=this.vif;
     gen.nextdrv=nextgd;
     gen.nextsco=nextgs;
     drv.nextdrv=nextgd;
     sco.nextsco=nextgs;
   endfunction
   
   task pre_test();
     drv.reset();
   endtask
   
   task test();
     fork
       gen.run();
       drv.run();
       mon.run();
       sco.run();
     join_any
   endtask
   
   task post_test();
     wait(gen.done.triggered);
     $display("total number of mismatch=%0d",sco.err);
     $finish();
   endtask
   
   task run();
     pre_test();
     test();
     post_test();
   endtask
   
 endclass
