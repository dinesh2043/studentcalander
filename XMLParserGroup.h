//
//  XMLParserGroup.h
//  MetroCalendar
//
//  Created by iosdev on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
@class SecondViewController,AppDelegate,Event;

@interface XMLParserGroup : UIViewController<NSXMLParserDelegate>{
    SecondViewController *RVC;
    NSMutableString *currentElementValue;
    NSEntityDescription *entity;
    AppDelegate *appDelegate;
    NSError *error;
    Event *aEvent;
    NSNumber *ID;
    BOOL boolen;
    NSFetchRequest *request;
    NSPredicate *predicate;
    IBOutlet UILabel *label;
    NSMutableData *receivedData;
    NSMutableArray *arrayID;
    BOOL myboolen;
    
}
- (void)parseData:(NSData *)data;



@property (nonatomic, retain)NSError *error;
@property (nonatomic, retain)Event *aEvent;
@property (nonatomic, retain)NSNumber *ID;
@property (nonatomic, retain)NSEntityDescription *entity;
@property (nonatomic, retain)NSFetchRequest *request;
@property (nonatomic,retain)NSPredicate *predicate;
@property(nonatomic,retain)SecondViewController *RVC;
@property (nonatomic, retain)IBOutlet UILabel *label;
@property (nonatomic, retain)NSMutableData *receivedData;
@property (nonatomic, retain)NSMutableArray *arrayID;

@end


