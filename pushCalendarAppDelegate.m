//
//  pushCalendarAppDelegate.m
//  pushCalendar
//
//  Created by iosdev on 11/6/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "pushCalendarAppDelegate.h"
#import "pushCalendarViewController.h"
#import "ListingView.h"
#import "Event.h"



@implementation pushCalendarAppDelegate

@synthesize window = _window;
@synthesize viewController = _viewController;
@synthesize managedObjectContext = __managedObjectContext;
@synthesize managedObjectModel = __managedObjectModel;
@synthesize persistentStoreCoordinator = __persistentStoreCoordinator;
@synthesize msg;
@synthesize navigationController;
@synthesize arrayID;


NSString *keyForNotification = @"joo";

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
     
    Class cls = NSClassFromString(@"UILocalNotification");
	if (cls) {
		UILocalNotification *notification = [launchOptions objectForKey:
                                             UIApplicationLaunchOptionsLocalNotificationKey];
		
		if (notification) {
			NSString *reminderText = [notification.userInfo 
									  objectForKey:keyForNotification];
			[self showReminder:reminderText];
		}
	}
	
	application.applicationIconBadgeNumber = 0;

    
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    
    // Let the device know we want to receive push notifications
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes: UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound];    
    
    return YES;
}

- (void)application:(UIApplication *)application 
didReceiveLocalNotification:(UILocalNotification *)notification {
	
	NSLog(@"GOT SOMETHING: %@",notification);
	application.applicationIconBadgeNumber = 0;
	NSString *reminderText = [notification.userInfo
							  objectForKey:keyForNotification];
    //	[EviewController showReminder:reminderText];
    
    [self showReminder:reminderText];
}
- (void)showReminder:(NSString *)text {
	
	UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Reminder" 
                                                        message:text delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
	[alertView show];
	
}



- (void)application:(UIApplication*)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken
{
	NSLog(@"My token is: %@", deviceToken);
    NSString* newToken = [deviceToken description];
    
    
    // change the token to hexadecimal            string.
    
    NSInteger user_id=5;
    
    newToken = [newToken stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    newToken = [newToken stringByReplacingOccurrencesOfString:@" " withString:@""];  // change the token to hexadecimal            string.
    NSLog(@"new token is %@", newToken);
    
    NSString *urlString = [NSString stringWithFormat:@"http://ec2-204-236-207-173.compute-1.amazonaws.com/test/gettoken.php?newToken=%@&user_id=%d",newToken,user_id];
    
    
    NSLog(@"my token in urlstring: %@",urlString);
    NSURL *url = [[NSURL alloc] initWithString:urlString];
    
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    
    //NSData *urlData;
    NSURLResponse *response;
    NSError *error;
    //urlData = [NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error];
    
    NSString *responseData= [[NSString alloc] initWithData:[NSURLConnection sendSynchronousRequest:urlRequest returningResponse:&response error:&error] encoding:NSUTF8StringEncoding]; 
    
    
    //NSLog(@"error is %@\n", error);
    //NSLog(@"url data: %@\n",urlData );
    NSLog(@"server response is %@\n", responseData);
    
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
	NSLog(@"Failed to get token, error: %@", error);
}



- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}


- (void)awakeFromNib
{
    ListingView *rootViewController = (ListingView *)[self.viewController parentViewController];
    rootViewController.managedObjectContext = self.managedObjectContext;}

- (void)saveContext
{
    NSError *error = nil;
    NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
    NSLog(@"I am called to save the context");
    
    if (managedObjectContext != nil)
    {
        if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error])
        {
            /*
             Replace this implementation with code to handle the error appropriately.
             
             abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
             */
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            NSLog(@"I am called to  check errors");
            abort();
        } 
    }
}

#pragma mark - Core Data stack

/**
 Returns the managed object context for the application.
 If the context doesn't already exist, it is created and bound to the persistent store coordinator for the application.
 */
- (NSManagedObjectContext *)managedObjectContext
{
    if (__managedObjectContext != nil)
    {
        //this method is called when some values is added to the context 
        return __managedObjectContext;
         
    }
    
    NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
    if (coordinator != nil)
    {
        __managedObjectContext = [[NSManagedObjectContext alloc] init];
        [__managedObjectContext setPersistentStoreCoordinator:coordinator];
    }
    return __managedObjectContext;
}

/**
 Returns the managed object model for the application.
 If the model doesn't already exist, it is created from the application's model.
 */
- (NSManagedObjectModel *)managedObjectModel
{
    if (__managedObjectModel != nil)
    {
        return __managedObjectModel;
          
    }
    NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"DataStore" withExtension:@"momd"];
    __managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
     NSLog(@"url of datastore %@",modelURL);
    return __managedObjectModel;
   
  
}

/**
 Returns the persistent store coordinator for the application.
 If the coordinator doesn't already exist, it is created and the application's store added to it.
 */
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator
{
    if (__persistentStoreCoordinator != nil)
    {
        return __persistentStoreCoordinator;
    }
    
    NSURL *storeURL = [[self applicationDocumentsDirectory] URLByAppendingPathComponent:@"DataStore.sqlite"];
    
    NSError *error = nil;
    __persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
    if (![__persistentStoreCoordinator addPersistentStoreWithType:NSSQLiteStoreType configuration:nil URL:storeURL options:nil error:&error])
        NSLog(@"Problem with PersistentStoreCoordinator: %@",error);

    {
        /*
         Replace this implementation with code to handle the error appropriately.
         
         abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development. If it is not possible to recover from the error, display an alert panel that instructs the user to quit the application by pressing the Home button.
         
         Typical reasons for an error here include:
         * The persistent store is not accessible;
         * The schema for the persistent store is incompatible with current managed object model.
         Check the error message to determine what the actual problem was.
         
         
         If the persistent store is not accessible, there is typically something wrong with the file path. Often, a file URL is pointing into the application's resources directory instead of a writeable directory.
         
         If you encounter schema incompatibility errors during development, you can reduce their frequency by:
         * Simply deleting the existing store:
         [[NSFileManager defaultManager] removeItemAtURL:storeURL error:nil]
         
         * Performing automatic lightweight migration by passing the following dictionary as the options parameter: 
         [NSDictionary dictionaryWithObjectsAndKeys:[NSNumber numberWithBool:YES], NSMigratePersistentStoresAutomaticallyOption, [NSNumber numberWithBool:YES], NSInferMappingModelAutomaticallyOption, nil];
         
         Lightweight migration will only work for a limited set of schema changes; consult "Core Data Model Versioning and Data Migration Programming Guide" for details.
         
         */
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        //abort();
    }    
    
    return __persistentStoreCoordinator;
}

#pragma mark - Application's Documents directory

/**
 Returns the URL to the application's Documents directory.
 */
- (NSURL *)applicationDocumentsDirectory
{
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

@end

