//
//  TTAppDelegate.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@interface TTAppDelegate : UIResponder <UIApplicationDelegate>{
    NSManagedObjectContext *_managedObjectContext;
    NSManagedObjectModel *_managedObjectModel;
    NSPersistentStoreCoordinator *_persistentStoreCoordinator;
}

@property (strong, nonatomic) UIWindow *window;



@end
