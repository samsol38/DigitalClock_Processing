

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