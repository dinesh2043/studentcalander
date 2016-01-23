//
//  DetailViewController.m
//  MetroCalendar
//
//  Created by iosdev on 11/24/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailViewController.h"


@implementation DetailViewController
@synthesize aEvent;
@synthesize description,Date,title;
@synthesize id_String,date_String;
@synthesize tableView;
@synthesize event_id;


-(IBAction)setalarm
{
    setalarm.reminderText.text = title;
    setalarm.detailText.text = description;
    NSLog(@"description %@", description);
    
    setalarm.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    SetAlarm *alarm = [[SetAlarm alloc] init];
    
    [self presentModalViewController:alarm animated:YES];
    
}

-(IBAction)mapview
{
    
    
    mapview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    MapView *alarm = [[MapView alloc] init];
    
    [self presentModalViewController:alarm animated:YES];
    
}



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}
-(void) showView:(Event*) entity{
    
	title = [entity valueForKey:@"title"];
	description = [entity valueForKey:@"eventDescription"];
	Date = [entity valueForKey:@"date"];
    event_id = [entity valueForKey:@"eventID"];
    
    
    NSLog(@"title: %@",title);
    NSLog(@"description: %@",description);
    NSLog(@"date: %@",Date);
    NSLog(@"Event: %@",event_id);
    
	
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
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
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

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    //#warning Potentially incomplete method implementation.
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //#warning Incomplete method implementation.
    // Return the number of rows in the section.
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell...
    
	switch(indexPath.section)
	{
		case 0:
			cell.textLabel.text =title;
            NSLog(@"title cell :%@",title);
			break;
		case 1:
			cell.textLabel.text =description;
			break;
		case 2:
			cell.textLabel.text =Date;
			break;
            
        case 3:
            cell.textLabel.text =[NSString stringWithFormat:@"%d",[event_id intValue]];;
            break;
            
	}
    
    return cell;
}
- (NSString *)tableView:(UITableView *)tblView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionName = nil;
	
	switch(section)
	{
		case 0:
			sectionName = [NSString stringWithString:@"Title"];
			break;
		case 1:
			sectionName = [NSString stringWithString:@"Description"];
			break;
		case 2:
			sectionName = [NSString stringWithString:@"Date"];
			break;
        case 3:
            sectionName = [NSString stringWithString:@"Event ID"];
            break;
	}
	
	return sectionName;
}


@end
