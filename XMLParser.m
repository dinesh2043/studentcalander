//
//  XMLParser.m
//  EventClientDB
//
//  Created by iosdev on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParser.h"
#import "pushCalendarAppDelegate.h"

@implementation XMLParser


@synthesize error;
@synthesize aEvent;
@synthesize ID;
@synthesize entity;
@synthesize request,predicate;


-(XMLParser *)initXMLParser{
    self = [super init];
    
    appDelegate = (pushCalendarAppDelegate *)[[UIApplication sharedApplication] delegate];
    return self;
}

//XMLParser.m
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    
    if([elementName isEqualToString:@"calendar"]) {
        NSLog(@"delegate array%@",appDelegate.arrayID);
        //Initialize the array.
        //appDelegate.events = [[NSMutableArray alloc] init];
        error = nil;
        
    }
    else if([elementName isEqualToString:@"event"]) {
        
        //Extract the attribute here.
        //aEvent.eventID=[[attributeDict objectForKey:@"event_id"] integerValue]];
        ID = [NSNumber numberWithInt:[[attributeDict objectForKey:@"event_id"] integerValue]];
        //[aEvent setValue:ID forKey:@"eventID"];
        
        aEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:[appDelegate managedObjectContext]];
                    aEvent.eventID=ID;
        
        
        //[aEvent setValue:ID forKey:@"eventID"];
        
        //aEvent.eventID = ID;
        //aEvent.eventID = [NSNumber numberWithInt:[[attributeDict objectForKey:@"event_id"] integerValue]];
        
        //ESVC.myEventId = ID;
        //NSLog(@"Reading id value :%@", ID);
        
    }
    
    //NSLog(@"Processing Element: %@", elementName);
}

//XMLParser.m
- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    
    if(!currentElementValue)
        currentElementValue = [[NSMutableString alloc] initWithString:string];
    else{
        [currentElementValue appendString:string];
        
        //NSLog(@"Processing Value: %@", currentElementValue);
    }
    
}


- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    
    if([elementName isEqualToString:@"calendar"]) {
        // consider saving the context here?
        
        [appDelegate saveContext];
        return;
    }
    
    //There is nothing to do if we encounter the Event element here.
    //If we encounter the Event element howevere, we want to add the event object to the array
    // and release the object.
    if([elementName isEqualToString:@"event"]) {
        //[appDelegate.events addObject:aEvent];
        
        //NSLog(@"My events: %@",appDelegate.events);
        //[appDelegate saveContext];
        //[aEvent release];
        //aEvent = nil;
    }
    else{
        
        //aEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext://[appDelegate managedObjectContext]];
        if ([elementName isEqualToString:@"title"]) {
            [aEvent setValue:currentElementValue forKey:@"title"];
        }
        else if ([elementName isEqualToString:@"description"]) {
            [aEvent setValue:currentElementValue forKey:@"eventDescription"];
        }
        else if ([elementName isEqualToString:@"date"]) {
            [aEvent setValue:currentElementValue forKey:@"date"];
        }
        
        else if ([elementName isEqualToString:@"location"]) {
            [aEvent setValue:currentElementValue forKey:@"location"];
        }
        
        
        //[aEvent setValue:currentElementValue forKey:elementName];
        
        currentElementValue = nil;
        
        
        
    }
}



@end
