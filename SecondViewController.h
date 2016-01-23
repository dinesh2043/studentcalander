//
//  SecondViewController.h
//  MetroCalendar
//
//  Created by iosdev on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Event.h"


@class  AppDelegate, DetailViewController,XMLParserGroup;

@interface SecondViewController : UIViewController<NSFetchedResultsControllerDelegate>{
    
    AppDelegate *appDelegate;
    DetailViewController *eventViewController;
    Event *event;
    //NSMutableArray *idArray;
    UITableView *tableView;    
}

-(void)saveObject:(NSDictionary *)dict;
-(void)insertNewObject:(NSDictionary *)MyEvent;

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
//@property (nonatomic, strong) NSMutableArray *idArray;
@property (nonatomic, strong) AppDelegate *appDelegate;
@property(nonatomic,strong)IBOutlet UITableView *tableView;
 



@end
