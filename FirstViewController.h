//
//  FirstViewController.h
//  MetroCalendar
//
//  Created by iosdev on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"

@interface FirstViewController : UIViewController{
    
    CalendarView *cVc;

}

@property (nonatomic,strong) IBOutlet  CalendarView *cVc;
@end
