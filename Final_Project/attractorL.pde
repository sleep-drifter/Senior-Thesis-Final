class AttractorLeft {

  // We need to keep track of a Body and a radius
  Body body;
  Fixture fixture;
  float r;

  AttractorLeft(float r_, float x, float y) {
    r = r_;
    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    fixture = body.createFixture(cs, 1);
    //body.createFixture(cs,1);
  }


  // Formula for gravitational attraction
  // We are computing this in "world" coordinates
  // No need to convert to pixels and back
  Vec2 attract(CircleLeft p) {
    float G = strengthForce; // Strength of force
    // clone() makes us a copy
    Vec2 pos = body.getWorldCenter();    
    Vec2 moverPos = p.body.getWorldCenter();
    // Vector pointing from mover to attractor
    Vec2 force = pos.sub(moverPos);
    float distance = force.length();
    // Keep force within bounds
    distance = constrain(distance, 1, 5);
    force.normalize();
    // Note the attractor's mass is 0 because it's fixed so can't use that
    float strength = (G * 1 * p.body.m_mass) / (distance * distance); // Calculate gravitional force magnitude
    force.mulLocal(strength);         // Get force vector --> magnitude * direction
    return force;
  }

  //LEFT SIDE --------------------------------------------------------------------------------------------------------------
  void displayEILeft() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void displaySNLeft() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void displayTFLeft() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }
  void displayJPLeft() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  //RIGHT SIDE --------------------------------------------------------------------------------------------------------------

  void displayEIRight() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void displaySNRight() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void displayTFRight() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }
  void displayJPRight() {
    // We look at each body and get its screen position
    Vec2 pos = box2d.getBodyPixelCoord(body);
    // Get its angle of rotation
    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(100);
    stroke(0);
    strokeWeight(1);
    ellipse(0, 0, r*2, r*2);
    popMatrix();
  }

  void update(float x, float y) {
    body.destroyFixture(fixture);
    // Define a body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    // Set its position
    bd.position = box2d.coordPixelsToWorld(x, y);
    body = box2d.world.createBody(bd);

    // Make the body's shape a circle
    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);
    fixture = body.createFixture(cs, 1);
  }
}

