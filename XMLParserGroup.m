//
//  XMLParserGroup.m
//  MetroCalendar
//
//  Created by iosdev on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "XMLParserGroup.h"
#import "AppDelegate.h"
#import "Event.h"

@implementation XMLParserGroup
@synthesize RVC;
@synthesize aEvent;
@synthesize ID;
@synthesize entity;
@synthesize request,predicate,error;
@synthesize label;
@synthesize receivedData;
@synthesize arrayID;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ec2-204-236-207-173.compute-1.amazonaws.com/test/pull_data1.php"]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    } else {
        NSLog(@"nothing received");
    }
    
    //AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSEntityDescription *entityDesc = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:context];
    request = [[NSFetchRequest alloc]init];
    [request setEntity:entityDesc];
    
    NSError *error1;
    NSManagedObject *matches = nil;
    NSArray *objects = [context executeFetchRequest:request error:&error1];
    
    NSInteger countMatchObject=[objects count];
    int counter=0;
    arrayID = [[NSMutableArray alloc]init];
    
    while (countMatchObject!=0) {
        matches = [objects objectAtIndex:counter];
        counter++;
        NSString *dateString=[matches valueForKey:@"eventID"];
        
        countMatchObject--;
        
        
        [arrayID addObject:dateString];
        NSLog(@"my array XML %@",arrayID );
        
    }
    [super viewDidLoad];
    
    
    // Do any additional setup after loading the view from its nib.
    
    // Do any additional setup after loading the view from its nib.
}
// NSURLConnection will cal this method when it did receive resonse
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[receivedData setLength:0];
}
// NSURLConnection will cal this method when it didReceiveData
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[receivedData appendData:data];
}
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	NSLog(@"Succeeded! Received %d bytes of data",[receivedData length]);
	[self parseData:receivedData];
}
- (void)parseData:(NSData *)data {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:self]; // The parser calls methods in this class
	[parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
	[parser setShouldReportNamespacePrefixes:NO]; //
	[parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	[parser parse]; // Parse that data..
	
}

//XMLParser.m
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName
    attributes:(NSDictionary *)attributeDict {
    
    
    if([elementName isEqualToString:@"calendar"]) {
       
        //Initialize the array.
        //appDelegate.events = [[NSMutableArray alloc] init];
        error = nil;
        
    }
    else if([elementName isEqualToString:@"event"]) {
        
        //Extract the attribute here.
        //aEvent.eventID=[[attributeDict objectForKey:@"event_id"] integerValue]];
        ID = [NSNumber numberWithInt:[[attributeDict objectForKey:@"event_id"] integerValue]];
        //[aEvent setValue:ID forKey:@"eventID"];
        myboolen = FALSE;
        
        for (int i=0; i<[arrayID count]; i++) {
            NSNumber *check=[arrayID objectAtIndex:i];
            NSLog(@"%@",check);
            if ([check intValue]==[ID intValue]) {
                myboolen = TRUE;
                //NSLog(@"%@",myboolen);
                NSLog(@"array check");
            }
        }
        if (myboolen==FALSE) {
           aEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:[appDelegate managedObjectContext]];
           aEvent.eventID=ID;
            NSLog(@"called to add objects in managed object context");
        }
        
        
        
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
    else if (myboolen==FALSE){
        
        //aEvent = (Event *)[NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:[appDelegate managedObjectContext]];
        if ([elementName isEqualToString:@"title"]) {
            [aEvent setValue:[currentElementValue substringFromIndex:3] forKey:@"title"];
        }
        else if ([elementName isEqualToString:@"description"]) {
            [aEvent setValue:[currentElementValue substringFromIndex:3] forKey:@"eventDescription"];
        }
        else if ([elementName isEqualToString:@"date"]) {
            NSLog(@"date from parser %@",[currentElementValue substringFromIndex:3]);
            
            NSDateFormatter *formate1 = [[NSDateFormatter alloc] init];  
            [formate1 setDateFormat:@"yyyy-mm-dd hh:mm:ss"];
            
            NSDate *Date1 = [formate1 dateFromString:[currentElementValue substringFromIndex:3]];
            
            NSLog(@"formatted date: %@",Date1);
            NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc]init];
            dateFormatter1.dateFormat = @"yyyy-mm-dd";
            
            NSString *dateString1 = [dateFormatter1 stringFromDate: Date1];
            
            
            
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
            timeFormatter.dateFormat = @"HH:mm:ss";
            
            
            NSString *timeString1 = [timeFormatter stringFromDate: Date1];

            NSLog(@"Start :%@,%@",timeString1,dateString1);
            //[aEvent setValue:[currentElementValue substringFromIndex:3] forKey:@"date"];
            aEvent.date=dateString1;
            aEvent.startTime=timeString1;

        }
        else if([elementName isEqualToString:@"end_date"]){
            NSDateFormatter *formate = [[NSDateFormatter alloc] init];  
            [formate setDateFormat:@"yyyy-MM-dd hh:mm:ss"];  
            NSDate *Date = [formate dateFromString:[currentElementValue substringFromIndex:3]];
            
            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
            dateFormatter.dateFormat = @"yyyy-MM-dd";
            
            NSString *dateString = [dateFormatter stringFromDate: Date];
            
            
            
            NSDateFormatter *timeFormatter = [[NSDateFormatter alloc]init];
            timeFormatter.dateFormat = @"HH:mm:ss";
            
            
            NSString *timeString = [timeFormatter stringFromDate: Date];
            
            NSLog(@"End :%@,%@",timeString,dateString);

            aEvent.endDate=dateString;
            aEvent.endTime=timeString;
            
        }
        else if ([elementName isEqualToString:@"location"]) {
            [aEvent setValue:[currentElementValue substringFromIndex:3] forKey:@"location"];
        }
        
        
        //[aEvent setValue:currentElementValue forKey:elementName];
        
        
        currentElementValue = nil;
        
        
        
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
