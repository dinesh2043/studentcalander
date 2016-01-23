//
//  DetailedView.m
//  pushCalendar
//
//  Created by iosdev on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "DetailedView.h"

@implementation DetailedView

@synthesize aEvent;
@synthesize description,Date,title;
@synthesize id_String,date_String;
@synthesize tableView;
@synthesize event_id;


-(IBAction)back
{
    [self dismissModalViewControllerAnimated:YES];
}

-(IBAction)setalarm
{
    setalarm.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    SetAlarm *alarm = [[SetAlarm alloc] init];
    [self presentModalViewController:alarm animated:YES];

}
-(IBAction)mapview
{
    mapview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    MapView *themap = [[MapView alloc] init];
    [self presentModalViewController:themap animated:YES];

}



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

/*
 // Implement loadView to create a view hierarchy programmatically, without using a nib.
 - (void)loadView
 {
 }
 */


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
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

@end
