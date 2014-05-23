void displayAllCircles(){
    //LEFT SIDE ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //Extraversion and Introversion group of circles
  for (int i = 0; i < extraIntraLeft.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorLeft.attract(extraIntraLeft.get(i));
    extraIntraLeft.get(i).applyForce(force);
    extraIntraLeft.get(i).displayEILeft();
  }

  //Sensing and Intuition group of circles
  for (int i = 0; i < senseIntuitionLeft.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorLeft.attract(senseIntuitionLeft.get(i));
    senseIntuitionLeft.get(i).applyForce(force);
    senseIntuitionLeft.get(i).displaySNLeft();
  }


  //Thinking and Feeling group of circles
  for (int i = 0; i < thinkFeelLeft.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorLeft.attract(thinkFeelLeft.get(i));
    thinkFeelLeft.get(i).applyForce(force);
    thinkFeelLeft.get(i).displayTFLeft();
  }

  //Judgement and Perception group of circles
  for (int i = 0; i < judgePerceptionLeft.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorLeft.attract(judgePerceptionLeft.get(i));
    judgePerceptionLeft.get(i).applyForce(force);
    judgePerceptionLeft.get(i).displayJPLeft();
  }

  // Display EI circles
  for (CircleLeft b: extraIntraLeft) {
    b.displayEILeft();
  }
  // Display SN circles
  for (CircleLeft b2: senseIntuitionLeft) {
    b2.displaySNLeft();
  }

  // Display TF circles
  for (CircleLeft b3: thinkFeelLeft) {
    b3.displayTFLeft();
  }

  // Display TF circles
  for (CircleLeft b4: judgePerceptionLeft) {
    b4.displayJPLeft();
  }



  // deleted when done is true (off screen or opacity <20
  for (int i = extraIntraLeft.size()-1; i >= 0; i--) {
    CircleLeft b = extraIntraLeft.get(i);
    if (b.done()) {
      extraIntraLeft.remove(i);
    }
  }

  for (int i = senseIntuitionLeft.size()-1; i >= 0; i--) {
    CircleLeft b2 = senseIntuitionLeft.get(i);
    if (b2.done()) {
      senseIntuitionLeft.remove(i);
    }
  }

  for (int i = thinkFeelLeft.size()-1; i >= 0; i--) {
    CircleLeft b2 = thinkFeelLeft.get(i);
    if (b2.done()) {
      thinkFeelLeft.remove(i);
    }
  }

  for (int i = judgePerceptionLeft.size()-1; i >= 0; i--) {
    CircleLeft b2 = judgePerceptionLeft.get(i);
    if (b2.done()) {
      judgePerceptionLeft.remove(i);
    }
  }

  //RIGHT SIDE ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  //Extraversion and Introversion group of circles
  for (int i = 0; i < extraIntraRight.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorRight.attract(extraIntraRight.get(i));
    extraIntraRight.get(i).applyForce(force);
    extraIntraRight.get(i).displayEIRight();
  }

  //Sensing and Intuition group of circles
  for (int i = 0; i < senseIntuitionRight.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorRight.attract(senseIntuitionRight.get(i));
    senseIntuitionRight.get(i).applyForce(force);
    senseIntuitionRight.get(i).displaySNRight();
  }


  //Thinking and Feeling group of circles
  for (int i = 0; i < thinkFeelRight.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorRight.attract(thinkFeelRight.get(i));
    thinkFeelRight.get(i).applyForce(force);
    thinkFeelRight.get(i).displayTFRight();
  }

  //Judgement and Perception group of circles
  for (int i = 0; i < judgePerceptionRight.size()-1; i++) {
    // Look, this is just like what we had before!
    Vec2 force = attractorRight.attract(judgePerceptionRight.get(i));
    judgePerceptionRight.get(i).applyForce(force);
    judgePerceptionRight.get(i).displayJPRight();
  }


  // Display EI circles
  for (CircleRight b: extraIntraRight) {
    b.displayEIRight();
  }
  // Display SN circles
  for (CircleRight b2: senseIntuitionRight) {
    b2.displaySNRight();
  }

  // Display TF circles
  for (CircleRight b3: thinkFeelRight) {
    b3.displayTFRight();
  }

  // Display TF circles
  for (CircleRight b4: judgePerceptionRight) {
    b4.displayJPRight();
  }


  //delete when done is true (either off screen or opacity <20)
  for (int i = extraIntraRight.size()-1; i >= 0; i--) {
    CircleRight b = extraIntraRight.get(i);
    if (b.done()) {
      extraIntraRight.remove(i);
    }
  }

  for (int i = senseIntuitionRight.size()-1; i >= 0; i--) {
    CircleRight b2 = senseIntuitionRight.get(i);
    if (b2.done()) {
      senseIntuitionRight.remove(i);
    }
  }

  for (int i = thinkFeelRight.size()-1; i >= 0; i--) {
    CircleRight b2 = thinkFeelRight.get(i);
    if (b2.done()) {
      thinkFeelRight.remove(i);
    }
  }

  for (int i = judgePerceptionRight.size()-1; i >= 0; i--) {
    CircleRight b2 = judgePerceptionRight.get(i);
    if (b2.done()) {
      judgePerceptionRight.remove(i);
    }
  }
  
    //addedmargin here
  if (eiLeftSaturation<0) {
    addedMarginL=abs(eiLeftSaturation)/4;
  } else{
    addedMarginL=0;
  }
  if (eiRightSaturation<0) {
    addedMarginR=abs(eiLeftSaturation)/4;
  }  else{
    addedMarginR=0;
  }


}
