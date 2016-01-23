//
//  DetailViewController.h
//  MetroCalendar
//
//  Created by iosdev on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Event.h"
#import "SetAlarm.h"
#import "MapView.h"

@class SetAlarm;
@class MapView;

@interface DetailViewController : UIViewController
{
    IBOutlet SetAlarm *setalarm;
    IBOutlet MapView *mapview;
    IBOutlet UITableView *tableView;
    Event *aEvent;
    NSString *description;
    NSString *Date;
    NSString *id_String;
    NSString *date_String;
    NSNumber *event_id;
}
@property(nonatomic,strong)Event *aEvent;
@property (nonatomic, strong)NSString *description;
@property (nonatomic, strong)NSString *Date;
@property (nonatomic, strong) NSString *id_String;
@property (nonatomic, strong) NSString *date_String;
@property (nonatomic,strong)NSNumber *event_id;
@property (nonatomic, strong)IBOutlet UITableView *tableView;


-(void) showView:(Event*) entity;
-(IBAction)setalarm;
-(IBAction)mapview;

@end
