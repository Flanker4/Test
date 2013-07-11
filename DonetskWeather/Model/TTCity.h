//
//  TTCity.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TTWeather;

@interface TTCity : NSManagedObject

@property (nonatomic, retain) NSString * idx;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSSet *wheter;
@end

@interface TTCity (CoreDataGeneratedAccessors)

- (void)addWheterObject:(TTWeather *)value;
- (void)removeWheterObject:(TTWeather *)value;
- (void)addWheter:(NSSet *)values;
- (void)removeWheter:(NSSet *)values;

@end
