//
//  pushCalendarViewController.m
//  pushCalendar
//
//  Created by iosdev on 10/26/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pushCalendarViewController.h"
#import "AddEvent.h"
#import "DetailedView.h"
#import "UserView.h"
#import "JourneyPlanner.h"
#import "AddLocation.h"
#import "ListingView.h"
#import "RepeatEvent.h"
#import "pushCalendarAppDelegate.h"


@implementation pushCalendarViewController

-(IBAction)addevent
{
    addevent.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    AddEvent *addE = [[AddEvent alloc] init];
    [self presentModalViewController:addE animated:YES];

}

-(IBAction)addlocation
{
    addlocation.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:addlocation animated:YES];
}

-(IBAction)detailedview
{
    NSLog(@"button pushed");
    detailedview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    DetailedView *details = [[DetailedView alloc] init];
    [self presentModalViewController:details animated:YES];
}

-(IBAction)userview
{
    userview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    UserView *user = [[UserView alloc] init];
    [self presentModalViewController:user animated:YES];
}

-(IBAction)journeyplanner
{
    journeyplanner.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentModalViewController:journeyplanner animated:YES];
}

-(IBAction)listingview
{
    
    /*
    ListingView *listingview = [[ListingView alloc]initWithNibName:@"ListingView" bundle:nil];
    [self.navigationController pushViewController:listingview animated:YES];
    */
    
    listingview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    ListingView *listing = [[ListingView alloc] init];
    [self presentModalViewController:listing animated:YES];
     
    
}




- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}
*/

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
