//
//  pushCalendarAppDelegate.h
//  pushCalendar
//
//  Created by iosdev on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CalendarView.h"
#import "AddEvent.h"

@class pushCalendarViewController;

@interface pushCalendarAppDelegate : NSObject <UIApplicationDelegate>
{
    UINavigationController *navigationController;

    NSMutableArray *arrayID;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet pushCalendarViewController *viewController;
@property (strong, nonatomic) UINavigationController *navigationController;
@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (strong,nonatomic)CalendarView *msg;
@property (nonatomic, strong) NSMutableArray *arrayID;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;




extern NSString *keyForNotification;
- (void)showReminder:(NSString *)text;



extern NSString *keyForNotification;

@end
