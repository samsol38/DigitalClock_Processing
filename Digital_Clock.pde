
float iwidth, iheight;
float tempSize;
float size, margin;

SevenSegment hourSegment;
SevenSegment minuteSegment;

SevenSegment secondSegment;
SevenSegment milliSecondSegment;

SegmentDot secondDotRight1;
SegmentDot secondDotRight2;
SegmentDot secondDotRight3;


void setup(){
  
  //size(displayWidth, displayHeight);
  
  //iwidth = displayWidth;
  //iheight = displayHeight;
  
  size(500, 500);
  
  iwidth = 500;
  iheight = 500;
  
  margin = 40.0;
  
  size = min(iwidth, iheight);
  
  size -= 4*margin;
  size /= 3;
  
  hourSegment = new SevenSegment(size, size);
  minuteSegment = new SevenSegment(size, size);
  
  secondSegment = new SevenSegment(size, size);
  //milliSecondSegment = new SevenSegment(size, size);
  
  secondDotRight1 = new SegmentDot(margin, size);
  secondDotRight2 = new SegmentDot(margin, size);
  //secondDotRight3 = new SegmentDot(margin, size);
  
}

void draw(){
  
  background(0, 0, 0, 255);
  smooth();
  
  float ix, iy;
  
  if(iwidth > iheight){
    
    tempSize = min(iwidth, iheight);
  
    ix = max(iwidth, iheight) - 3*size - 2*margin;
    ix /= 2.0;
  
    iy = tempSize / 2 - size / 2;
    
  }else{
    
    tempSize = max(iwidth, iheight);
  
    ix = min(iwidth, iheight) - 3*size - 2*margin;
    ix /= 2.0;
  
    iy = tempSize / 2 - size / 2;
    
  }
  
  hourSegment.display(ix, iy, TimeMode.HOUR);
  minuteSegment.display(ix + size + margin, iy, TimeMode.MINUTE);
  
  secondSegment.display(ix + 2*size + 2*margin, iy, TimeMode.SECOND);
  //milliSecondSegment.display(ix + 3*size + 3*margin, iy, TimeMode.HUNDREDSECOND);
  
  secondDotRight1.display(ix + size, iy);
  secondDotRight2.display(ix + size*2 + margin, iy);
  //secondDotRight3.display(ix + size*3 + 2*margin, iy);
}

class TimeMode {
  
    static final int HOUR = 1,
    MINUTE = 2,
    SECOND = 3,
    HUNDREDSECOND = 4;

}

class SevenSegment{
  
  float swidth, sheight;
  float margin;
  
  int rightDigit1, rightDigit2;
  int digitState[][];
  
  SevenSegment(){
    swidth = 0.0;
    sheight = 0.0;
    
    this.setDefaultParam();
  }
  
  SevenSegment(float iwid, float ihei){
    swidth = iwid;
    sheight = ihei;
    
    this.setDefaultParam();
  }
  
  void setDefaultParam(){
    
    margin = 10.0;
    digitState = new int[10][];
    
    digitState[0] = new int[]{1, 1, 1, 0, 1, 1, 1};
    digitState[1] = new int[]{0, 0, 1, 0, 0, 1, 0};
    
    digitState[2] = new int[]{1, 0, 1, 1, 1, 0, 1};
    digitState[3] = new int[]{1, 0, 1, 1, 0, 1, 1};
    
    digitState[4] = new int[]{0, 1, 1, 1, 0, 1, 0};
    digitState[5] = new int[]{1, 1, 0, 1, 0, 1, 1};
    
    digitState[6] = new int[]{1, 1, 0, 1, 1, 1, 1};
    digitState[7] = new int[]{1, 1, 1, 0, 0, 1, 0};
    
    digitState[8] = new int[]{1, 1, 1, 1, 1, 1, 1};
    digitState[9] = new int[]{1, 1, 1, 1, 0, 1, 1};
    
  }
  
  void display(float x, float y, int imode){
    
    int timeElement = 0;
    
    strokeWeight(2);
    stroke(255, 255, 255, 100);
    noFill();
    
    switch(imode){
     
      case TimeMode.HOUR: {
        timeElement = hour();
        timeElement = (timeElement > 12) ? (timeElement - 12) : timeElement;
      }
      
      break;
      
      case TimeMode.MINUTE : {
        timeElement = minute();
      }
      
      break;
      
      case TimeMode.SECOND : {
        timeElement = second();
      }
      
      break;
      
      case TimeMode.HUNDREDSECOND : {
        
        timeElement = (int)((millis() % 100));
        //println(timeElement);
        
        if(timeElement >= 100){
          timeElement = 0;
        }
      }
      
      break;
      
      default : {
        
      }
      
      break;
      
    }
    
    rightDigit1 = timeElement % 10;
    rightDigit2 = timeElement / 10;
    
    displayDigit(x, y, swidth/2 - margin, sheight, digitState[rightDigit2]);
    displayDigit(x + swidth/2 + margin, y, swidth/2 - margin, sheight, digitState[rightDigit1]);
    
  }
  
  void displayDigit(float x, float y, float iwid, float ihei, int[] state){
    
    float barWeight = 5;
    float verticalHeight = ihei/2 - (1.5)*barWeight;
    
    float strokeOpacity = 30;
    
    strokeWeight(0);
    stroke(255, 255, 255, strokeOpacity);
    noFill();
    rect(x, y, iwid, ihei);
    
    strokeWeight(4);
    
    //  Top
    
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[0]);
    rect(x + barWeight, y, iwid - 2*barWeight, barWeight);
    
    //  mid
    
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[3]);
    rect(x + barWeight, y + ihei/2 - barWeight/2, iwid - 2*barWeight, barWeight);
    
    //  bottom
    
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[6]);
    rect(x + barWeight, y + ihei - barWeight, iwid - 2*barWeight, barWeight);

    //  Top Left - Right
    
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[1]);
    rect(x, y + barWeight, barWeight, verticalHeight);

    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[2]);
    rect(x + iwid - barWeight, y + barWeight, barWeight, verticalHeight);
    
    //  Bottom Left - Right
    
    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[4]);
    rect(x, y + ihei/2 + barWeight/2, barWeight, verticalHeight);

    stroke(255, 255, 255, strokeOpacity);
    fill(255, 255, 255, 255*state[5]);
    rect(x + iwid - barWeight, y + ihei/2 + barWeight/2, barWeight, verticalHeight);
    
  }
  
}

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