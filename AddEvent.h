//
//  AddEvent.h
//  pushCalendar
//
//  Created by iosdev on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DatePickView;
@class RepeatEvent;
@class CalendarView;
@class SecondViewController;
@class AppDelegate;

@interface AddEvent : UIViewController<NSXMLParserDelegate,UITextFieldDelegate>
{
    
    IBOutlet DatePickView *datepickview;
    IBOutlet RepeatEvent *repeatevent;
    
    IBOutlet UITextField *titleText;
    IBOutlet UITextView *descripText;
    IBOutlet UITextField *dateText;
    IBOutlet UITextField *timeText;
    IBOutlet UITextField *startTimeText;
    IBOutlet UITextField *endTimeText;
    IBOutlet UITextField *Address;
    IBOutlet UILabel *Response;
    AppDelegate *appDelegate;
    
    SecondViewController *svc;
    
    NSString *serverResponse;
    NSString *title;
    NSString *description;
    NSString *eventDate;
    NSString *eventStartTime;
    NSString *eventEndTime;
    NSInteger intId;
    NSNumber *myEventId;
    NSString *Addresses;
    
    
    NSMutableString *foundString;
    NSMutableData *receivedData;
    IBOutlet UIScrollView *scrollView;
    
    CalendarView *cVc;
    
    
}


-(IBAction)pickdate;
-(IBAction)sendData:(id)sender;
-(IBAction)removeKeyboard:(id)sender;
-(void)parseData:(NSData *)data;
-(IBAction)repeatevent;

@property (nonatomic ,strong) UITextField *titleText; 
@property (nonatomic ,strong) UITextView *descripText; 
@property (nonatomic ,strong) UITextField *dateText;
@property (nonatomic ,strong) UITextField *startTimeText;
@property (nonatomic ,strong) UITextField *endTimeText;
@property (nonatomic,strong) NSMutableString *foundString;
@property (nonatomic ,strong) NSMutableData *receivedData;
@property (nonatomic,strong) CalendarView *cVc;
@property (nonatomic,strong) SecondViewController *svc;
@property (nonatomic,strong) NSNumber *myEventId;
@property (nonatomic,strong) UIScrollView *scrollView;
@property (nonatomic, strong) UITextField *Address;
@property (nonatomic, strong) NSString *Addresses;
@property (nonatomic, strong) AppDelegate *appDelegate;


@end
