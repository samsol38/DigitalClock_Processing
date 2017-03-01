

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