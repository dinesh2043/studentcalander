//
//  FirstViewController.m
//  MetroCalendar
//
//  Created by iosdev on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#import "AddEvent.h"
#import "XMLParserGroup.h"
#import "CalendarView.h"

@implementation FirstViewController
@synthesize cVc;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"First", @"First");
        self.tabBarItem.image = [UIImage imageNamed:@"first"];
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}



- (void)myTap:(UIGestureRecognizer *)sender {
    CGPoint location = [sender locationInView:self.view];
    NSLog(@"myTap. x = %f, y = %f", location.x, location.y);
    
    AddEvent *addEvent = [[AddEvent alloc] initWithNibName:@"AddEvent" bundle:nil];
    
    [self.navigationController pushViewController:addEvent animated:YES];
    
    // NSLog(@"here i am Long Pressed");
    
    
    
}
//Next Swipe Function

-(void)NextSwipes:(UISwipeGestureRecognizer *)sender{
    
    
    if(sender.direction & UISwipeGestureRecognizerDirectionLeft){
        [cVc moveNextMonth];
    }
    
    NSLog(@"here i am left swiped");
} 

//Prev Swipe Function
-(void)PrevSwipes:(UISwipeGestureRecognizer *)sender{
    
    
    if(sender.direction & UISwipeGestureRecognizerDirectionRight){
        [cVc movePrevMonth]; 
    }
    
    NSLog(@"here i am right swiped");
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    [super viewDidLoad];
    
    CGRect touchFrame = CGRectMake(40, 80, 320, 205);
    UIView *touchView = [[UIView alloc]initWithFrame:touchFrame];
    //touchView.backgroundColor = [UIColor colorWithRed:0.1 green:0.5 blue:0.1 alpha:0.9]; 
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(myTap:)];
    tap.numberOfTapsRequired = 2;
    [touchView addGestureRecognizer:tap];
    [self.cVc addSubview:touchView];
    
    /* Swipe Functionalities*/
    UISwipeGestureRecognizer *swipeGestureRecognizerNext = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self action:@selector(NextSwipes:)];
    UISwipeGestureRecognizer *swipeGestureRecognizerPrev = [[UISwipeGestureRecognizer alloc]
                                                            initWithTarget:self action:@selector(PrevSwipes:)];
    /* Swipes that are performed from right to
     left are to be detected */
    swipeGestureRecognizerNext.direction = UISwipeGestureRecognizerDirectionLeft;
    
    /* Just one finger needed */ 
    swipeGestureRecognizerNext.numberOfTouchesRequired = 1;
    /* Add it to the view */
    [self.cVc addGestureRecognizer:swipeGestureRecognizerNext];
    
    
    //Prev Swipe
    
    swipeGestureRecognizerPrev.direction = UISwipeGestureRecognizerDirectionRight;
    
    /* Just one finger needed */ 
    swipeGestureRecognizerPrev.numberOfTouchesRequired = 1;
    /* Add it to the view */
    [self.cVc addGestureRecognizer:swipeGestureRecognizerPrev];
    // Swipe Ends Here
    
    
    
    
    
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSLog(@"YAHOO");
    [[self parentViewController] setTitle:@"Metro Calendar"];
    
//    [[self parentViewController] navigationItem].leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFastForward target:self action:@selector(buttonAdd)];
//    
//    [[self parentViewController] navigationItem].rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(buttonGroup)];
    
    
}

- (void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    NSLog(@"I am herere");
    
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
