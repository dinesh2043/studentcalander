//
//  AddEvent.m
//  pushCalendar
//
//  Created by iosdev on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AddEvent.h"
//#import "DatePickView.h"
//#import "RepeatEvent.h"
#import "SecondViewController.h"
#import "AppDelegate.h"

@implementation AddEvent

@synthesize titleText;
@synthesize descripText;
@synthesize dateText;
@synthesize startTimeText;
@synthesize endTimeText;
@synthesize receivedData;
@synthesize foundString;
@synthesize cVc;
@synthesize svc;
@synthesize myEventId;
@synthesize Address;
@synthesize scrollView;
@synthesize Addresses;
@synthesize appDelegate;



-(IBAction)pickdate
{
    //[self presentModalViewController:datepickview animated:YES];
}

-(IBAction)repeatevent
{
    //[self presentModalViewController:repeatevent animated:YES];
}




-(IBAction)removeKeyboard:(id)sender{
    
    [titleText resignFirstResponder];
    [descripText resignFirstResponder];
    [dateText resignFirstResponder];
    [startTimeText resignFirstResponder];
    [endTimeText resignFirstResponder];
    
    
}

#pragma mark- Send Data to server

-(NSMutableString *)createXML:(NSString *) xmldata
{    
    NSMutableString *data1 = [NSMutableString stringWithString:@"<?xml version=\"1.0\" encoding=\"ISO-8859-1\" ?>\n"];
    [data1 appendString:@"<calendar>\n"];
    [data1 appendString:@"\t<event>\n"];
    [data1 appendString:@"\t\t<event_id></event_id>\n"];
    [data1 appendString:@"\t\t<title>"];    
    [data1 appendString:title];
    [data1 appendString:@"</title>\n"];
    [data1 appendString:@"\t\t<venue_id>1</venue_id>\n"];
    [data1 appendString:@"\t\t<contact_id>1</contact_id>\n"];
    [data1 appendString:@"\t\t<description>"];
    [data1 appendString:description];
    [data1 appendString:@"</description>\n"];
    [data1 appendString:@"\t\t<category_id>1</category_id>\n"];
    [data1 appendString:@"\t\t<user_id>1</user_id>\n"];
    [data1 appendString:@"\t\t<group_id>1</group_id>\n"];
    [data1 appendString:@"\t\t<status_id>1</status_id>\n"];
    [data1 appendString:@"\t\t<date>"];
    [data1 appendString:eventDate];
    [data1 appendString:@"</date>\n"];
    [data1 appendString:@"\t\t<starttime>"];
    [data1 appendString:eventStartTime];
    [data1 appendString:@"</starttime>\n"];
    [data1 appendString:@"\t\t<endtime>"];
    [data1 appendString:eventEndTime];
    [data1 appendString:@"</endtime>\n"];
    [data1 appendString:@"\t</event>\n"];
    [data1 appendString:@"</calendar>\n"];
    NSLog(@" %@",data1);
    
    return data1;
}
-(void)XmlSend
{
    
    NSError *error = nil;
    NSString *targetURL= @"http://ec2-204-236-207-173.compute-1.amazonaws.com/test/EventInput.php";
    NSURLResponse *response;
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:targetURL]];
    NSMutableString *params = [NSMutableString stringWithString:@"calendar="];
    [params appendString:[self createXML:nil]];
    NSLog(@"params = %@",params);
    
    [request setHTTPMethod:@"POST"];
    
    [request setHTTPBody:[params dataUsingEncoding:NSUTF8StringEncoding]];
    NSLog(@"my request%@",request);
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    NSString *responseData= [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error] encoding:NSUTF8StringEncoding];
    
    NSLog(@"response %@",responseData);
    [Response setText: responseData];
    // Response.text=responseData;
    serverResponse=responseData;
}

- (void)parseData:(NSData *)data {
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:data];
	[parser setDelegate:self]; // The parser calls methods in this class
	[parser setShouldProcessNamespaces:NO]; // We don't care about namespaces
	[parser setShouldReportNamespacePrefixes:NO]; //
	[parser setShouldResolveExternalEntities:NO]; // We just want data, no other stuff
	[parser parse]; // Parse that data..
}


-(IBAction)sendData:(id)sender{
    title = titleText.text;
    description = descripText.text;
    eventDate = dateText.text;
    eventStartTime = startTimeText.text;
    eventEndTime = endTimeText.text;
    Addresses = Address.text;
    
    //    NSDateFormatter *formate = [[[NSDateFormatter alloc] init] autorelease];  
    //    [formate setDateFormat:@"yyyy-MM-dd"];  
    //    NSDate *Date = [formate dateFromString:eventDate];  
    //    NSLog(@"Output :%@",Date);
    NSDateFormatter *formate1 = [[NSDateFormatter alloc] init];  
    [formate1 setDateFormat:@"HH:mm:ss"];  
    NSDate *Time = [formate1 dateFromString:eventDate];  
    NSLog(@"Output :%@",Time);
    
    //for fixing id problems only for the time beings it should be changed latter
    intId++;
    myEventId = [NSNumber numberWithInt:intId];
    NSLog(@"my int value%@",myEventId);

    
    //AppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = [appDelegate managedObjectContext];
    NSManagedObject *event;
    
    event = [NSEntityDescription insertNewObjectForEntityForName:@"Event" inManagedObjectContext:context];
    [event setValue:myEventId forKey:@"eventID"];
    [event setValue:title forKey:@"title"];
    [event setValue:description forKey:@"eventDescription"];
    [event setValue:eventDate forKey:@"date"];
    [event setValue:eventStartTime forKey:@"startTime"];
    [event setValue:eventEndTime forKey:@"endTime"];
    [event setValue:Addresses forKey:@"address"];
    NSError *error;
    [context save:&error];
    
    [self createXML:nil];
    [self XmlSend];
    UIAlertView *alert = 
	[[UIAlertView alloc] initWithTitle:@"Data Saved to Database" 
							   message:serverResponse 
							  delegate:self 
					 cancelButtonTitle:@"OK" 
					 otherButtonTitles:nil];    
    
    [alert show];     
    
}








/*- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
 {
 self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
 if (self) {
 // Custom initialization
 }
 return self;
 }*/

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    //[super viewDidLoad];
    
    scrollView.frame = CGRectMake(0, 0, 320, 460);
    [scrollView setContentSize:CGSizeMake(320, 678)];
    self.title=@"Create Event";
    dateText.delegate =self;
    foundString = [[NSMutableString alloc] initWithCapacity:50];
    [foundString appendString:@"Event_id:"];
    //    dictionaryStack = [[NSMutableArray alloc] init];
    //    nameArray = [[NSMutableArray alloc] initWithObjects:nil];
    //    
    //    [dictionaryStack addObject:[NSMutableDictionary dictionary]];
    //    firstTime = YES ;
    NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://ec2-204-236-207-173.compute-1.amazonaws.com/test/pull_data1.php"]cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
    if (theConnection) {
        receivedData = [NSMutableData data];
    } else {
        NSLog(@"nothing received");
    }
    [super viewDidLoad];
    
    // Do any additional setup after loading the view from its nib.

}
#pragma mark- XML parsing sent from server
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



// this will be called when parser starts inspecting a tag <tag>!!
-  (void)parser:(NSXMLParser *)parser 
didStartElement:(NSString *)elementName
   namespaceURI:(NSString *)namespaceURI 
  qualifiedName:(NSString *)qName
     attributes:(NSDictionary *)attributeDict {
    if ( [elementName isEqualToString:@"event"]   )  {
        myEventId = [NSNumber numberWithInt:[[attributeDict valueForKey:@"event_id"] integerValue]];
        //if([myEventId isEqualToNumber:myID]){
        // allowString = YES; 
        //}
        NSLog(@"Event id %@",myEventId); 
        
        intId = [myEventId integerValue];
        NSLog(@"int id %d",intId);
        
        //[foundString appendString:string];
        // if(string==@"10")
        //URL.text =  foundString ;
    }       
    
    
    
}








- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
