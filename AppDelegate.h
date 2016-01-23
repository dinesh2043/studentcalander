//
//  AppDelegate.h
//  MetroCalendar
//
//  Created by iosdev on 11/23/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <CoreData/CoreData.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>{
    
    UINavigationController *navigationController;
    NSMutableArray *arrayID;
}

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) UINavigationController *navigationController;

@property (nonatomic, strong, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, strong, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@property (nonatomic, strong) NSMutableArray *arrayID;


extern NSString *keyForNotification;
- (void)showReminder:(NSString *)text;

@end
