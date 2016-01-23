//
//  CalendarView.h
//  ICalendar
//
//  Created by iosdev on 11/14/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h" 
#import "AddEvent.h"



@interface CalendarView : UIView{
    
    CFGregorianDate currentMonthDate; // instance for the currentMonthDate
    CFAbsoluteTime currentTime; // AbsoluteTime instance for current time
    CFGregorianDate currentWeek;
    CFGregorianDate currentSelectDate; //selected date instance
    UIImageView *viewImageView;    
    AddEvent *eventVc;
    
    
}

@property CFGregorianDate currentMonthDate;
@property CFGregorianDate currentSelectDate;
@property CFAbsoluteTime currentTime;
@property CFGregorianDate currentWeek;
@property(nonatomic,strong)UIImageView *viewImageView;
@property(nonatomic,strong)AddEvent *eventVc; 




-(void)drawNameOfDaysAtTop ; //method to display name of the day at top
-(void)drawTopGradientBar; // method to draw gradient
-(void)drawDateBoxes; // method to draw cells
-(void)changeColor;
-(void)createAddevent;
- (void)moveNextMonth;
- (void)movePrevMonth;

-(int)getDayCountOfaMonth:(CFGregorianDate )date; //get the number of days of the particular month
-(int)getMonthWeekday:(CFGregorianDate)date; //get the current month
-(int)getWeekOfYear:(CFGregorianDate)date; //get the first week of the selected month


@end

