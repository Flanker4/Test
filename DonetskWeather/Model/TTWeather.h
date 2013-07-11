//
//  TTWeather.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class TTCity;


//for temp attribute
extern NSInteger const TTWEATHER_TEMP_NONE;


@interface TTWeather : NSManagedObject

@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * text;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * day;
@property (nonatomic, retain) NSNumber * code;
@property (nonatomic, retain) NSNumber * temp;
@property (nonatomic, retain) NSNumber * tempLow;
@property (nonatomic, retain) NSNumber * tempHigh;
@property (nonatomic, readonly) NSString *temperature;
@property (nonatomic, retain) TTCity *city;



@end
