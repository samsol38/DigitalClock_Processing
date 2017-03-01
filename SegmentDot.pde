

class SegmentDot{
  
  float swidth, sheight;
  float margin, barWeight;
  
  SegmentDot(){
    swidth = 0.0;
    sheight = 0.0;
    
    this.setDefaultParam();
  }
  
  SegmentDot(float iwid, float ihei){
    swidth = iwid;
    sheight = ihei;
    
    this.setDefaultParam();
  }
  
  void setDefaultParam(){
    
    margin = 10.0;
    barWeight = 7;
    
  }
  
  void display(float x, float y){
    
    float strokeOpacity = 35;
    
    strokeWeight(2);
    stroke(255, 255, 255, 0);
    noFill();
    rect(x, y, swidth, sheight);
    
    strokeWeight(4);
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*((int)(millis()/500) % 2));
    
    rect(x + (swidth - barWeight)/2, y + (sheight - 2*barWeight)/3, barWeight, barWeight);
    rect(x + (swidth - barWeight)/2, y + 2*(sheight - 2*barWeight)/3 + barWeight, barWeight, barWeight);  
  }
  
}