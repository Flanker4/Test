//
//  TTAppDelegate+DataProvider.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 10.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTAppDelegate.h"

extern NSString *const kTTNotificationDataUpdated;


@interface TTAppDelegate (DataProvider)

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;



- (void)saveContext;
//Core Data
- (NSURL *)applicationDocumentsDirectory;

@property (nonatomic,strong,readonly) TTCity * donetsk;

//
// DESCRIPTION: Add weather items to city
// PARAMS:      NSArray with TTWeatherItems
// RESULT:      void
//
-(void) addWeatherItem:(NSArray*)items city:(TTCity*)city;

//
// DESCRIPTION: Add weather items to Donetsk city
// PARAMS:
// RESULT:      void
//
-(void) addWeatherItem:(NSArray*)items;


//
// DESCRIPTION: get weathers for two days
// PARAMS:      city
// RESULT:      array of TTWeather
//
-(TTWeather*) weatherForDay:(NSDate*)date city:(TTCity*)city;

//
// DESCRIPTION: get weathers for two days (donetsk)
// PARAMS:
// RESULT:      array of TTWeather
//
-(TTWeather*) weatherForDay:(NSDate*)date;

-(void) preloadData;
@end
