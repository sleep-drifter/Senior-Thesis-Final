//touchOSC events
void oscEvent(OscMessage theOscMessage) {
  String addr = theOscMessage.addrPattern();
  //print("### received an osc message.");
  float val = theOscMessage.get(0).floatValue();


  //NEW VALUES
  //LEFT SIDE************************************************************
  
  //restart sketch
   if (addr.equals("/1/push3")) { 
    restartButton = val;
     //change.trigger();
  }
 if (addr.equals("/1/push1")) { 
    restartValue = val;
     //change.trigger();
  }
  if (addr.equals("/1/leftEI")) { 
    eiLeftSaturation = val;
     //change.trigger();
  }
  if (addr.equals("/1/leftSN")) { 
    snLeftSaturation = val;
     //change.trigger();
  }
  if (addr.equals("/1/leftTF")) { 
    tfLeftSaturation = val;
     //six.trigger();
  }
  if (addr.equals("/1/leftJP")) { 
    jpLeftSaturation = val;
   
  }

  //RIGHT SIDE************************************************************
  //GOOOD
  if (addr.equals("/1/rightEI")) { 
    eiRightSaturation = val;

     //two.trigger();
       
  }
  if (addr.equals("/1/rightSN")) { 
    snRightSaturation = val;
     //three.trigger();
  }
  if (addr.equals("/1/rightTF")) { 
    tfRightSaturation = val;
   
  }
  //GOOD
  if (addr.equals("/1/rightJP")) { 
    jpRightSaturation = val;
    
  }
}

