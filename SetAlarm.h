//
//  SetAlarm.h
//  pushCalendar
//
//  Created by iosdev on 11/28/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DetailedView;
@interface SetAlarm : UIViewController <UITextFieldDelegate> {
    
    DetailedView *Evc;
	UITextField *reminderText;
    UITextField *detailText;
	UIButton *setButton;
	UIButton *clearButton;
	UIDatePicker *datePicker;
}

@property (nonatomic,retain) IBOutlet UITextField *reminderText;
@property (nonatomic,retain) IBOutlet UITextField *detailText;
@property (nonatomic,retain) IBOutlet UIButton *setButton;
@property (nonatomic,retain) IBOutlet UIButton *clearButton;
@property (nonatomic,retain) IBOutlet UIDatePicker *datePicker;
@property (nonatomic,retain) DetailedView *Evc;

- (IBAction)clearNotification;
- (IBAction)scheduleNotification;
- (void)showReminder:(NSString *)text;
@end

