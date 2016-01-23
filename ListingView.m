//
//  ListingView.m
//  pushCalendar
//
//  Created by iosdev on 11/25/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "ListingView.h"

@implementation ListingView

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    [self dismissModalViewControllerAnimated:YES];
}


-(IBAction)detailedview
{
    detailedview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    DetailedView *details = [[DetailedView alloc] init];
    [self presentModalViewController:details animated:YES];
}

-(IBAction)addlocation
{
    [self presentModalViewController:addlocation animated:YES];
}

-(IBAction)userview
{
    [self presentModalViewController:userview animated:YES];
}

-(IBAction)journeyplanner
{
    [self presentModalViewController:journeyplanner animated:YES];
}

- (void)viewDidLoad
{
    //this warning is due to import of delegate
    
    //appDelegate =(pushCalendarAppDelegate *)[[UIApplication sharedApplication]delegate];
    
    if (__managedObjectContext == nil) 
    { 
        __managedObjectContext = [(pushCalendarAppDelegate *)[[UIApplication sharedApplication] delegate] managedObjectContext]; 
    }
    
    
    //self.title=@"Events";
    [super viewDidLoad];
    
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddButton)];
    self.navigationItem.rightBarButtonItem = addButton;
    
    
    
    //initializing the array
    idArray = [[NSMutableArray alloc ]init];
    
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem =self.editButtonItem;
    //UIBarButtonItem *addGroup = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(AddGroup)];
    //self.navigationItem.leftBarButtonItem = addGroup;
    //initializing the array
    //appDelegate.arrayID = [[NSMutableArray alloc ]init];
    
}

- (void)AddGroup{
	//XMLParserGroup *xmlParserGroup = [[XMLParserGroup alloc] initWithNibName:@"XMLParserGroup" bundle:nil];
    // ...
    // Pass the selected object to the new view controller.
	//xmlParserGroup.RVC = self;
    //[self.ListingView pushViewController:xmlParserGroup animated:YES];
    [xmlParserGroup getID:idArray];
    [self presentModalViewController:xmlParserGroup animated:YES];
    
    
}
/*
 - (void)AddButton{
 EventSenderViewController *eventSenderViewController = [[EventSenderViewController alloc] initWithNibName:@"EventSenderViewController" bundle:nil];
 // ...
 // Pass the selected object to the new view controller.
 eventSenderViewController.rootVC = self;
 [self.navigationController pushViewController:eventSenderViewController animated:YES];
 
 [eventSenderViewController release];
 }
 */
-(void)saveObject:(NSDictionary *)dict{
    NSLog(@"data is saved properly in dictnary");
    [self insertNewObject:dict];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

/*
 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
 // Return YES for supported orientations.
 return (interfaceOrientation == UIInterfaceOrientationPortrait);
 }
 */

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        // Delete the managed object for the given index path
        NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
        [context deleteObject:[self.fetchedResultsController objectAtIndexPath:indexPath]];
        
        // Save the context.
        NSError *error = nil;
        if (![context save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            //    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            abort();
        }
    }   
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /* 
     DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
     // ...
     // Pass the selected object to the new view controller.
     Event *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
     
     NSLog(@"object selected: %@",selectedObject);
     
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController showView:selectedObject];
     
     */
    Event *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    [detailedview showView:selectedObject];
    NSLog(@"object selected: %@",selectedObject);
    
    detailedview.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    DetailedView *details = [[DetailedView alloc] init];
    [self presentModalViewController:details animated:YES];
    
    
    
	
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

@end
