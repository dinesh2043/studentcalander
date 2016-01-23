//
//  CalendarView.m
//  IphoneCalendar
//
//  Created by iosdev on 11/10/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "CalendarView.h"
#import <QuartzCore/QuartzCore.h>
#import "AddEvent.h"
#import "AppDelegate.h"


const unsigned int uppermargin =80;

const float width=40;
const  float height=35;
const  float prevNextButtonSize=20;
const  float prevNextButtonSpaceWidth=15;
const float prevNextButtonSpaceHeight=10;

@implementation CalendarView

@synthesize currentMonthDate;
@synthesize currentSelectDate;
@synthesize currentTime;
@synthesize viewImageView;
@synthesize currentWeek ;
@synthesize eventVc;




-(void)initCalView{
	currentTime=CFAbsoluteTimeGetCurrent();
	currentMonthDate=CFAbsoluteTimeGetGregorianDate(currentTime,CFTimeZoneCopyDefault());
	currentMonthDate.day=1;
	currentSelectDate.year=0;
    currentWeek = CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopyDefault());
    [self getWeekOfYear:currentWeek];
    self.backgroundColor=[UIColor whiteColor];
    
    
    
}

- (id)initWithCoder:(NSCoder *)coder {
    if (self = [super initWithCoder:coder]) {
		[self initCalView];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame {
	
	if (self = [super initWithFrame:frame]) {
		[self initCalView];
	}
	return self;
}

#pragma mark -
#pragma mark function to get total days of the current month
-(int)getDayCountOfaMonth:(CFGregorianDate)date{
	switch (date.month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			return 31;
			
		case 2:
			if(date.year%4==0 && date.year%100!=0)
				return 29;
			else
				return 28;
		case 4:
		case 6:
		case 9:		
		case 11:
			return 30;
		default:
			return 31;
	}
}

#pragma mark Draw

-(void)drawPrevButton:(CGPoint)leftTop{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetGrayStrokeColor(ctx, 0, 1);
    CGContextMoveToPoint(ctx,leftTop.x , prevNextButtonSpaceWidth/2+leftTop.y);
    CGContextAddLineToPoint(ctx, prevNextButtonSize+leftTop.x, leftTop.y);
    CGContextAddLineToPoint(ctx, prevNextButtonSize+leftTop.x, prevNextButtonSize+leftTop.y);
    //CGContextAddLineToPoint(ctx, 0+leftTop.x, 0+leftTop.y);
    
    CGContextFillPath(ctx);
}


-(void)drawNextButton:(CGPoint )leftTop{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    CGContextSetGrayStrokeColor(ctx, 0, 1);
    CGContextMoveToPoint(ctx,leftTop.x,  leftTop.y);
    CGContextAddLineToPoint(ctx, prevNextButtonSize+leftTop.x, prevNextButtonSpaceHeight+leftTop.y);
    CGContextAddLineToPoint(ctx, 0+leftTop.x, prevNextButtonSize+leftTop.y);
    // CGContextAddLineToPoint(ctx, 0+leftTop.x, 0+leftTop.y);
    
    CGContextFillPath(ctx);
    
}

-(void)drawTopGradientBar{
    
    
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    size_t num_locations=3;
    CGFloat locations[3]={0.0,0.7,1.0};                     // total number of position
    CGFloat components[12]={0.0,0.30,0.0,1.0,
        0.5,0.5,0.5,0.5,
        0.40,0.0,0.10,1.0
    };                                                      // color combination
    CGGradientRef myGradient;
    CGColorSpaceRef myColorspace = CGColorSpaceCreateDeviceRGB();
    myGradient =CGGradientCreateWithColorComponents(myColorspace, components, locations, num_locations);
    CGPoint myStartPoint, myEndPoint;
    myStartPoint.x=uppermargin;
    myStartPoint.y=0.0;
    myEndPoint.x=uppermargin;
    myEndPoint.y=uppermargin;
    CGContextDrawLinearGradient(ctx, myGradient, myStartPoint, myEndPoint, 0);
    
    //------Release the Gradient and colorspace
    CGGradientRelease(myGradient);
    CGColorSpaceRelease(myColorspace);
    
    [self drawPrevButton:CGPointMake(10, 15)];
    [self drawNextButton:CGPointMake(290, 15)];
    
    
    
}


- (void)drawDateBoxes {
    
    int x,y;
    CGRect rectangle;
    // Drawing code
    for(int i =0;i<6;i++){
        y=i*height+uppermargin;
        
        for(int j =0;j<8;j++){
            x=j*width;
            
            CGMutablePathRef path = CGPathCreateMutable();              /*create the path first*/
            rectangle = CGRectMake(x, y, width, height);  /*our rectangle boundaries*/
            CGPathAddRect(path, NULL, rectangle);                       /*add the rectangle to the path*/
            CGContextRef currentContext =UIGraphicsGetCurrentContext(); /*get the handle to the current context*/
            CGContextAddPath(currentContext, path);                       /*add the path to the context*/
            [[UIColor colorWithRed:0.20f green:0.60f blue:0.0f alpha:0.25f]setFill];/*set the fill color*/
            [[UIColor colorWithRed:0.0f green:0.0f blue:0.10f alpha:0.1f]setStroke];                            //set the stroke color to brown
            CGContextSetLineWidth(currentContext, 1.0f);                                    /*set the line width*/
            CGContextDrawPath(currentContext, kCGPathFillStroke);       /*stroke and fill the path on the context*/
            CGPathRelease(path);     
        }/*dispose of the path*/
    }
    
    
}

#pragma mark -
#pragma mark function to draw Month Name at top

-(void)drawNameOfDaysAtTop {
    
    [[UIColor blackColor]set];
    int width = self.frame.size.width;// gives the total size of the frame ie 320
    int s_width = width/8;// we want to have the display in the same amount of distance 8 column
    int fontsize= [UIFont buttonFontSize]; //buttonFontSize returns the fonts suitable for a button
    NSString *monthName;
    int counter;
    switch (currentMonthDate.month) {
        case 1:
            monthName=@"January";
            counter = [monthName length];
            break;
        case 2:
            monthName=@"February";
            counter = [monthName length];
            break;
        case 3:
            monthName=@"March";
            counter = [monthName length];
            break;
        case 4:
            monthName=@"April";
            counter = [monthName length];
            break;
        case 5:
            monthName=@"May";
            counter = [monthName length];
            break;
        case 6:
            monthName=@"June";
            counter = [monthName length];
            break;
        case 7:
            monthName=@"July";
            counter = [monthName length];
            break;
        case 8:
            monthName=@"August";
            counter = [monthName length];
            break;
        case 9:
            monthName=@"September";
            counter = [monthName length];
            break;
        case 10:
            monthName=@"October";
            counter = [monthName length];
            break;
        case 11:
            monthName=@"November";
            counter = [monthName length];
            break;
        case 12:
            monthName=@"December";
            counter = [monthName length];
            break;
            
        default:
            break;
    }
    
    NSString *title_Month = [[NSString alloc]initWithFormat:@"%@ %d",monthName,currentMonthDate.year];
    UIFont *font = [UIFont boldSystemFontOfSize:20];
    CGPoint location = CGPointMake( (width/2 -((counter+5)*11.5)/2), prevNextButtonSpaceHeight); //location holds the points set by cgpointmake
    
    [title_Month drawAtPoint:location withFont:font];    
    UIFont *weekfont = [UIFont boldSystemFontOfSize:15];
    
    fontsize+=23;
    
    [[UIColor brownColor]set];
    [@"Wk" drawAtPoint:CGPointMake(s_width*0+9,fontsize) withFont:weekfont];
    [[UIColor blackColor]set];
    [@"Mon" drawAtPoint:CGPointMake(s_width*0.89+9,fontsize) withFont:weekfont];
    [@"Tue" drawAtPoint:CGPointMake(s_width*1.89+9,fontsize) withFont:weekfont];
	[@"Wed" drawAtPoint:CGPointMake(s_width*2.89+9,fontsize) withFont:weekfont];
	[@"Thu" drawAtPoint:CGPointMake(s_width*3.89+9,fontsize) withFont:weekfont];
	[@"Fri" drawAtPoint:CGPointMake(s_width*4.89+9,fontsize) withFont:weekfont];
	[[UIColor colorWithRed:0.0 green:0.2 blue:1 alpha:0.9]set];
	[@"Sat" drawAtPoint:CGPointMake(s_width*5.89+9,fontsize) withFont:weekfont];
    [[UIColor redColor] set];
	[@"Sun" drawAtPoint:CGPointMake(s_width*6.8+9,fontsize) withFont:weekfont];
    [[UIColor blackColor]set];
    
    
}



#pragma mark -
#pragma mark function to get the first day of the month

- (int)getMonthWeekday:(CFGregorianDate)date{
    
    CFTimeZoneRef timezone= CFTimeZoneCopyDefault();
    CFGregorianDate month_date;
    month_date.year = date.year;
    month_date.month=date.month;
    month_date.day=1;
    month_date.hour=0;
    month_date.minute=0;
    month_date.second=1;      
    
    return (int)CFAbsoluteTimeGetDayOfWeek(CFGregorianDateGetAbsoluteTime(month_date, timezone), timezone);//2
    
}

#pragma mark -
#pragma mark function to get the current week of the month
-(int)getWeekOfYear:(CFGregorianDate)date{
    
    CFTimeZoneRef timezone= CFTimeZoneCopyDefault();
    CFGregorianDate month_date;
    month_date.year = date.year;
    month_date.month=date.month;
    month_date.day=1;
    month_date.hour=0;
    month_date.minute=0;
    month_date.second=1;
    
    return (int)CFAbsoluteTimeGetWeekOfYear(CFGregorianDateGetAbsoluteTime(month_date, timezone), timezone);
}

#pragma mark -
#pragma mark function to draw dates of the month

-(void)drawDateWords{
    
    CGContextRef ctx =UIGraphicsGetCurrentContext();
    int width = self.frame.size.width;
    
    int dayCount = [self getDayCountOfaMonth:currentMonthDate];
    int day =0;
    int x =0;
    int y =0,i;
    int s_width=width/8;
    int check_saturday=0;
    int check_week=90;
    
    int current_weekday = [self getMonthWeekday:currentMonthDate];  
    int getweekofthemonth = [self getWeekOfYear:currentMonthDate];
    NSLog(@"current week = %d",getweekofthemonth);
    
    
    //-------- Draw Week Numbers ----------------
    
    UIFont *weekfont =[UIFont boldSystemFontOfSize:15];        
    [[UIColor brownColor]set];
    
    for(int k =1;k<7;k++){
        
        if(getweekofthemonth==53){
            getweekofthemonth =52;
        }
        
        NSString *week = [[NSString alloc]initWithFormat:@"%2d",getweekofthemonth];   
        [week drawAtPoint:CGPointMake(s_width-30, check_week) withFont:weekfont];
        getweekofthemonth++;
        
        if(getweekofthemonth==53){
            getweekofthemonth =1;
        }
        
        check_week+=35;
        
    }
    
    
    [[UIColor blackColor]set];       
    for( i=1;i<dayCount+1;i++){
        day = i + current_weekday-2;  
        x = day%7;
        y=day/7;
        
        
        //printing 
        NSString *date = [[NSString alloc]initWithFormat:@"%2d",i];
        
        // Saturday and Sunday for colouring
        check_saturday=x*s_width+50;
        
        //--------- Draw the previous month days in front of empty cells-------------------------------
        if(i==1){
            CFGregorianDate prevMonthDate = CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopySystem());
            
            prevMonthDate.year=currentMonthDate.year;
            prevMonthDate.month= currentMonthDate.month-1;
            
            int prevmonthdayCount = [self getDayCountOfaMonth:prevMonthDate];
            int pos;
            int beginning=check_saturday-s_width;
            [[UIColor grayColor]set];
            for(pos=beginning;pos>=50;pos-=s_width){
                NSString *prevdate = [[NSString alloc]initWithFormat:@"%2d",prevmonthdayCount];
                [prevdate drawAtPoint:CGPointMake(pos, uppermargin+10) withFont:weekfont];
                prevmonthdayCount--;
                
            }
            [[UIColor blackColor]set];    
            
        }
        
        
        //colour saturday
        if(check_saturday ==250){
            [[UIColor blueColor]set];
            [date drawAtPoint:CGPointMake(x*s_width+50, y*35+uppermargin+10) withFont:weekfont];
            
        }
        
        //colour sunday
        else if(check_saturday == 290){
            [[UIColor redColor]set];
            [date drawAtPoint:CGPointMake(x*s_width+50, y*35+uppermargin+10) withFont:weekfont];
            
        }
        else{
            [date drawAtPoint:CGPointMake(x*s_width+50, y*35+uppermargin+10) withFont:weekfont];
            
        }
        
        CGContextSetRGBFillColor(ctx, 0, 0, 0, 1);
    }
    // -----------------------printing next month's dates ----------------
    int nextdate=1;
    int endx=(x+1)*s_width+50;
    [[UIColor grayColor]set];
    for(int endy=y*35+uppermargin+10;endy<=5*35+uppermargin+10;endy+=35){
        for(;endx<=6*s_width+50;endx+=s_width){
            NSString *nextdatestring = [[NSString alloc]initWithFormat:@"%2d",nextdate];
            [nextdatestring drawAtPoint:CGPointMake(endx, endy) withFont:weekfont];
            nextdate++;
            
        }
        endx=0*s_width+50;
        
    }
    //printing next month's dates ends here
    
}

// Display the view whenever the arrow is tapped
-(void)movePrevNext:(int)isPrev{
    
    currentSelectDate.year =0;
    
    
    int width=self.frame.size.width;
    int position;
    if(isPrev==1){
        position=width;
    }
    else
        position=-width;
    
    UIImage *viewImage;
    
    UIGraphicsBeginImageContext(self.bounds.size);
    [self.layer renderInContext:UIGraphicsGetCurrentContext()];
    viewImage = UIGraphicsGetImageFromCurrentImageContext();
    if(viewImageView ==nil){
        viewImageView = [[UIImageView alloc]initWithImage:viewImage];
        viewImageView.center=self.center;
        [[self superview]addSubview:viewImageView];
    }
    else
    {
        viewImageView.image=viewImage;
        
    }
    
    viewImageView.hidden =NO;
    viewImageView.transform = CGAffineTransformMakeTranslation(0, 0);
    self.hidden=YES;
    [self setNeedsDisplay];
    self.transform=CGAffineTransformMakeTranslation(position, 0);
    
    
    /* float height;
     int row_Count=([self getDayCountOfaMonth:currentMonthDate]+[self getMonthWeekday:currentMonthDate]-2)/7+1;
     height=row_Count*35+60;//
     self.frame=CGRectMake(self.frame.origin.x, self.frame.origin.y, self.frame.size.width, height);*/
	self.hidden=NO;
	[UIView beginAnimations:nil	context:nil];
	[UIView setAnimationDuration:0.5];
	self.transform=CGAffineTransformMakeTranslation(0,0);
	viewImageView.transform=CGAffineTransformMakeTranslation(-position, 0);
	[UIView commitAnimations];
    
}
//---------function to get the month and week for next month---------------- 
- (void)movePrevMonth{
    // int decrease=12;
	if(currentMonthDate.month>1){
		currentMonthDate.month-=1;
        
        [self getWeekOfYear:currentMonthDate];
        
        // NSLog(@"check the WeekHere1 %d",collectWeekNumbers);
    }
	else
	{
		currentMonthDate.month=12;
		currentMonthDate.year-=1;
        
	}
	[self movePrevNext:0]; 
    [self getWeekOfYear:currentMonthDate ];
    
    
}

//-------------function to get the month and week for previous month ------------------
- (void)moveNextMonth{
	if(currentMonthDate.month<12){
		currentMonthDate.month+=1;
        
        
    }
	else
	{
		currentMonthDate.month=1;
		currentMonthDate.year+=1;
        
	}
	[self movePrevNext:1];
    [self getWeekOfYear:currentMonthDate];
	
    
}
#pragma mark -
#pragma mark function to change the color of selected date
-(void)changeColor{
    int x;
    int y;
    int day;
    if(currentSelectDate.year !=0){
        int width = self.frame.size.width;
        int s_width=width/8;
        int weekday = [self getMonthWeekday:currentMonthDate];
        day=currentSelectDate.day+weekday-2;
        
        x=day%7;
        y=day/7;
        NSLog(@"s_width:%f x:%d y:%f",(float)x*s_width+s_width,day,y*height+uppermargin);
        
        //to shade the cell for today's date
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        CGContextSetRGBFillColor(ctx, 0.0, 0.5, 1.0, 0.2);
        CGContextMoveToPoint(ctx,  x*s_width+s_width,  y*height+uppermargin);
        CGContextAddLineToPoint(ctx,  x*s_width+s_width+40 ,  y*height+uppermargin);
        CGContextAddLineToPoint(ctx,  x*s_width+s_width+40,  y*height+uppermargin+height);
        CGContextAddLineToPoint(ctx,  x*s_width+s_width,  y*height+uppermargin+height);
        CGContextFillPath(ctx); 
        
    }
    
}

#pragma mark -
#pragma mark function to Create add Event View
-(void)createAddevent{
    
    
    
    /* AddEvent *addEvent = [[AddEvent alloc]initWithNibName:@"AddEvent" bundle:nil];
     
     addEvent.cVc=self;
     
     NSString *miti = [NSString stringWithFormat:@"%d-%d-%d",currentSelectDate.year,currentSelectDate.month,currentSelectDate.day];
     //AppDelegate *appDelegate=(AppDelegate *)[[UIApplication sharedApplication]delegate];
     
     //[appDelegate.navigationController pushViewController:addEvent animated:YES];
     
     addEvent.dateText.text = miti;
     
     NSLog(@"check this out miti:%@",miti);*/
    
    
    
}

- (void) touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	int width=self.frame.size.width;
    int x,y;
    
    int weekday=[self getMonthWeekday:currentMonthDate];// get the current month
    int monthDayCount=[self getDayCountOfaMonth:currentMonthDate];//get the total day of the month
    
	UITouch* touch=[touches anyObject];
	CGPoint touchPoint=[touch locationInView:self];
    int taps=[touch tapCount];
    
    x=((touchPoint.x-40)*7)/(width-40) ;
    NSLog(@"tap=%d",x);
    y=(touchPoint.y-(uppermargin))/height;
    int monthday=x+y*7-weekday+2;
    
	if(touchPoint.x<40 && touchPoint.y<40)
		[self movePrevMonth];
	else if(touchPoint.x>width-40 && touchPoint.y<40)
		[self moveNextMonth];
    else if((touchPoint.x>=40 && touchPoint.y>=80) && touchPoint.x < 320 && touchPoint.y<320 ){
        
        if(monthday>0 && monthday<monthDayCount+1){
            currentSelectDate.year=currentMonthDate.year;
            currentSelectDate.month=currentMonthDate.month;
            currentSelectDate.day=monthday;
            currentSelectDate.hour=0;
            currentSelectDate.minute=0;
            currentSelectDate.second=1; 
            
            if(taps==2)
                [self createAddevent];
            
            [self setNeedsDisplay];
            
        }
    }
    
}

#pragma mark -
#pragma mark function to draw dates of the month
-(void) drawToday{
    
    int x;
    int y;
    int day;
    CFGregorianDate today = CFAbsoluteTimeGetGregorianDate(currentTime, CFTimeZoneCopySystem());
    if(today.month == currentMonthDate.month && today.year==currentMonthDate.year){
        
        int width = self.frame.size.width;
        int s_width=width/8;
        int weekday = [self getMonthWeekday:currentMonthDate];
        day=today.day+weekday-2;
        x=day%7;
        y=day/7;
        
        CGContextRef ctx = UIGraphicsGetCurrentContext();
        
        
        //to shade the cell for today's date
	 	CGContextSetRGBFillColor(ctx, 0.5, 0.5, 0.5, 1);
		CGContextMoveToPoint(ctx, x*s_width+40, y*35+80);
		CGContextAddLineToPoint(ctx, x*s_width+s_width+40, y*35+80);
		CGContextAddLineToPoint(ctx, x*s_width+s_width+40, y*35+115);
		CGContextAddLineToPoint(ctx, x*s_width+40, y*35+115);
		CGContextFillPath(ctx); 
        
        
        CGContextSetRGBFillColor(ctx, 0, 1, 1, 1);
        UIFont *weekfont = [UIFont boldSystemFontOfSize:15];
        NSString *date = [[NSString alloc]initWithFormat:@"%2d",today.day];
        
        [date drawAtPoint:CGPointMake(x*s_width+50, y*35+90) withFont:weekfont];
        
    }
    
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    currentTime = CFAbsoluteTimeGetCurrent();
    [self drawTopGradientBar]; 
    
    [self drawNameOfDaysAtTop];
    [self drawDateBoxes];
    [self drawDateWords];
    [self changeColor];
    [self drawToday];
    
    
}


@end
