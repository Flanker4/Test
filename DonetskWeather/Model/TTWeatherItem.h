//
//  TTWeatherItem.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTWeatherItem : NSObject
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSString * text;
@property (nonatomic) int  code;
@property (nonatomic) int  temp;
@property (nonatomic) int  tempLow;
@property (nonatomic) int  tempHigh;
@end
