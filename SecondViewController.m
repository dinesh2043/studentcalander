//
//  RootViewController.m
//  EventClientDB
//
//  Created by iosdev on 10/21/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//
#import <CoreData/CoreData.h>
#import "SecondViewController.h"
#import "Event.h"
#import "DetailViewController.h"
#import "AddEvent.h"
#import "XMLParserGroup.h"
#import  "AppDelegate.h"
//#import "TableViewCell.h"



@interface SecondViewController ()

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;

@end

@implementation SecondViewController

@synthesize fetchedResultsController = __fetchedResultsController;
@synthesize managedObjectContext = __managedObjectContext;
//@synthesize idArray;
@synthesize appDelegate;
@synthesize tableView;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Second", @"Second");
        self.tabBarItem.image = [UIImage imageNamed:@"second"];
        
    }
    return self;
}


- (void)viewDidLoad
{
    //this warning is due to import of delegate
    
    //appDelegate =(AppDelegate *)[[UIApplication sharedApplication] delegate];
    if (__managedObjectContext == nil) 
    { 
        __managedObjectContext = [(AppDelegate *)[[UIApplication sharedApplication] delegate]managedObjectContext]; 
        //NSLog(@"After managedObjectContext: %@",  __managedObjectContext);
    }
    
    
    self.title=@"Events";
    
    
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //    UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(AddButton)];
    //    self.navigationItem.rightBarButtonItem = addButton;
    
    
    //initializing the array
    //idArray = [[NSMutableArray alloc ]init];
    
    // Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem =self.editButtonItem;
    [[self parentViewController] navigationItem].leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(buttonAdd)];
    
    [[self parentViewController] navigationItem].rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemBookmarks target:self action:@selector(buttonGroup)];
    
    //initializing the array
    //appDelegate.arrayID = [[NSMutableArray alloc ]init];
    [super viewDidLoad];
}
- (void) buttonAdd {
    AddEvent *ae = [[AddEvent alloc] initWithNibName:@"AddEvent" bundle:nil];
    [self.navigationController pushViewController:ae animated:YES];
}
-(void)buttonGroup{
    XMLParserGroup *xml =[[XMLParserGroup alloc] initWithNibName:@"XMLParserGroup" bundle:nil];
    [self.navigationController pushViewController:xml animated:YES];
    //[xml getID:idArray];
}

-(void)saveObject:(NSDictionary *)dict{
    NSLog(@"data is saved properly in dictnary");
    [self insertNewObject:dict];
    //[self reloadInputViews];
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
- (UITableViewCell *)tableView:(UITableView *)tableView1 cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
     */
    static NSString *CellIdentifier = @"Cell";
    
	static NSInteger TitleTag = 1;
	static NSInteger DateTag = 2;
    static NSInteger TimeTag = 3;
	
    UITableViewCell *cell = [tableView1 dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
		CGRect frame;
		frame.origin.x = 90; 
		frame.origin.y = 5;
		frame.size.height = 20;
		frame.size.width = 200;
        
        
		
		UILabel *titleLabel = [[UILabel alloc] initWithFrame:frame];
		titleLabel.tag = TitleTag;
        titleLabel.textColor =[UIColor blueColor];
		[cell.contentView addSubview:titleLabel];
		
		
		
		frame.origin.y += 16;
        frame.origin.x -= 85;
        frame.size.width = 70;
		UILabel *dateLabel = [[UILabel alloc] initWithFrame:frame];
		dateLabel.tag = DateTag;
        dateLabel.font =[UIFont fontWithName:@"American Typewriter" size:12];
		[cell.contentView addSubview:dateLabel];
        
        //frame.origin.y += 18;
        
        frame.origin.x += 260;
        frame.size.width = 70;
		UILabel *timeLabel = [[UILabel alloc] initWithFrame:frame];
		timeLabel.tag = TimeTag;
        timeLabel.font = [UIFont fontWithName:@"American Typewriter" size:12];
		[cell.contentView addSubview:timeLabel];

		
    }
    
    // Set up the cell...	
	// cell.text = [NSString stringWithFormat:@"State: %@ Capital: %@",[capitals objectAtIndex:indexPath.row],[states objectAtIndex:indexPath.row]];
	UILabel * titleLabel = (UILabel *) [cell.contentView viewWithTag:TitleTag];
	UILabel * dateLabel = (UILabel *) [cell.contentView viewWithTag:DateTag];
    UILabel * timeLabel = (UILabel *) [cell.contentView viewWithTag:TimeTag];
    
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];	
	titleLabel.text =[[managedObject valueForKey:@"title"] description];
    
	dateLabel.text =[[managedObject valueForKey:@"date"] description];
    timeLabel.text =[[managedObject valueForKey:@"startTime"] description];
    
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
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
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
    
    DetailViewController *detailViewController = [[DetailViewController alloc] initWithNibName:@"DetailViewController" bundle:[NSBundle mainBundle]];
    // ...
    // Pass the selected object to the new view controller.
    Event *selectedObject = [[self fetchedResultsController] objectAtIndexPath:indexPath];
    
    NSLog(@"object selected: %@",selectedObject);
    
    [self.navigationController pushViewController:detailViewController animated:YES];
    [detailViewController showView:selectedObject];
    
	
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"title"] description];
    //storing id values in array
    //[idArray addObject:[[managedObject valueForKey:@"eventID"] description]];
    //NSLog(@"my array: %@",idArray);
}

- (void)insertNewObject:(NSDictionary *)MyEvent
{
    // Create a new instance of the entity managed by the fetched results controller.
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSEntityDescription *entity = [[self.fetchedResultsController fetchRequest] entity];
    NSManagedObject *newManagedObject = [NSEntityDescription insertNewObjectForEntityForName:[entity name] inManagedObjectContext:context];
    
    // If appropriate, configure the new managed object.
    // Normally you should use accessor methods, but using KVC here avoids the need to add a custom class to the template.
    //[newManagedObject setValue:[NSDate date] forKey:@"timeStamp"];
    [newManagedObject setValuesForKeysWithDictionary:MyEvent];
    
    // Save the context.
    NSError *error = nil;
    if (![context save:&error])
    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        abort();
    }
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    
    // Edit the entity name as appropriate.
    //NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Event" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    //set predicates
    
    //fetchRequest.predicate = [NSPredicate predicateWithFormat:@"self==%@",event];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"eventID" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    NSLog(@"ID Array: %@",sortDescriptor);
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    //NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    
    aFetchedResultsController.delegate = self;
    
    NSLog(@"Featch resault: %@",aFetchedResultsController);
    self.fetchedResultsController = aFetchedResultsController;
    
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
	    /*
	     Replace this implementation with code to handle the error appropriately.
         
	     abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
	     */
	    NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
	    abort();
	}
    
    return __fetchedResultsController;
}    

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    //UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}

/*
 // Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
 {
 // In the simplest, most efficient, case, reload the table view.
 [self.tableView reloadData];
 }
 */

@end
