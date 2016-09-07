contract Middle {
    //variable
    address creatoraddr =  0x000000000000000; //customer
    address receiveraddr = 0x000000000000001; // service contractor
    address returnaddr =   0x000000000000000; //return address of customer
    string rulescontract = ""; //legal stuff about the transaction that will transcribe 
    string customerrequirements= ""; //the user here describes the service that will be delivered by the contractor
    string md5file; //md5 file
    bool accept = false;
    bool finaldeal; //finalise the deal - can be used by the customer to complete the transaction
   // bool fdeal;
    bool canceled = false; //cancel the deal - return money to the customer
   // bool cdeal;     
    bool once = true;
    uint payout;
    
    function setmd5(string x) {
    if(accept == false && canceled == false){
            
        if(msg.sender == receiveraddr){
       md5file = x;
        //run stuff
        }else throw;
      }else throw;    
    }

    function setfdeal(bool y) {
      //fdeal = y;
        //run stuff
      if(accept == false && canceled == false){
            
        
       if(y==true){
         completetrans();  
         } else throw;
    
      } else throw;   
    }
     
    function set(bool z) {
      if(accept == false && canceled == false){
        //run stuff
        if(msg.sender == receiveraddr && z == true && once == true){
          accept = z;
          // one time lock   
          once = false;
          //has accepted the contract
          //contractor gets an advance payment 1/4 (will add a custom rule) or not depends on user preferences
          payout = this.balance/4 ;
          address(receiveraddr).send(payout);
        }
      } else throw;           
    }
    //abort transaction
    function abort() {
     if(accept == false && canceled == false){
      //the deal hasnt been finalised - caused by a false in the final deal
        if (msg.sender == creatoraddr) {
         canceled = true;
         address(returnaddr).send(this.balance);
        }else throw;
      }else throw;
    }
    
    //complete transaction
     function completetrans() {
     if(accept == false || canceled == false){          
       if (msg.sender == creatoraddr) {
         finaldeal = true;
         address(receiveraddr).send(this.balance); //money contractor will recieve change this value
       }else throw;
     }else throw;
    }
     
}
