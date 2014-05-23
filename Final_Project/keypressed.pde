void updateAttractors() {
  
  boolean forceApplied = false;
  //toggle attract or repel
float attract = width/2;
float leftRepel = 0;
float rightRepel = width;

////table equations
String result = "";


for (TableRow row : table.rows()) {
    String type = row.getString("Type");
   //println(type);
    
    if (type.equals(left)) {
       //println("hooray! this is " + type);
       result = row.getString(right);
    }
    
  }

  //println("The result is " + result);

if(keyPressed){
if (key=='y'){
  forceApplied = true;
  attractorLeft.update(attract, leftAttractorDefaulty);
  attractorRight.update(attract, leftAttractorDefaulty);
}

if (key=='t'){
  forceApplied = true;
  attractorLeft.update(leftRepel, leftAttractorDefaulty);
  attractorRight.update(rightRepel, leftAttractorDefaulty);
}
}





if (result.equals("green")){
  
  forceApplied = true;
  setH=100;
         setS=200;

   if (runonce) {
     attracted.trigger();
     runonce = false;
              startIndicatorGrowth=true;

     strengthForce=8000;
     restitutionValue=0;
     
   }

  attractorLeft.update(attract, leftAttractorDefaulty);
  attractorRight.update(attract, leftAttractorDefaulty);
} else {
  runonce=true;
}

if (result.equals("red")){
       strengthForce=8000;
       setH=255;
       setS=200;

  forceApplied = true;
  attractorLeft.update(leftRepel, leftAttractorDefaulty);
  attractorRight.update(rightRepel, leftAttractorDefaulty);
  if (runonce2) {
     repel.trigger();
     runonce2 = false;
            startIndicatorGrowth=true;

     restitutionValue=0.8;
     
   }
}else{
  runonce2=true;
}
  if (forceApplied == false) {
         strengthForce=1000;
         restitutionValue=0.5;
         setS=0;

 attractorLeft.update(leftAttractorDefaultx, leftAttractorDefaulty);
 attractorRight.update(rightAttractorDefaultx, rightAttractorDefaulty);
  if (runonce3) {
             startIndicatorGrowth=true;

     normal.trigger();
     runonce3 = false;
     
   }

  }else{
    runonce3=true;

}
}

