//
//  XMLParser.h
//  EventClientDB
//
//  Created by iosdev on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Event.h"


@class pushCalendarAppDelegate, Event,pushCalendarViewController;

@interface XMLParser : NSObject<NSXMLParserDelegate>{
    NSMutableString *currentElementValue;
    NSEntityDescription *entity;
    pushCalendarAppDelegate *appDelegate;
    pushCalendarViewController *rvc;
    NSError *error;
    Event *aEvent;
    NSNumber *ID;
    BOOL boolen;
    NSFetchRequest *request;
    NSPredicate *predicate;
}
-(XMLParser *)initXMLParser;

@property (nonatomic, strong)NSError *error;
@property (nonatomic, strong)Event *aEvent;
@property (nonatomic, strong)NSNumber *ID;
@property (nonatomic, strong)NSEntityDescription *entity;
@property (nonatomic, strong)NSFetchRequest *request;
@property (nonatomic,strong)NSPredicate *predicate;

@end
