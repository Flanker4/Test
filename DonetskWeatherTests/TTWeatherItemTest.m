//
//  TTWeatherItemTest.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTWeatherItemTest.h"
#import "TTWeatherItem.h"
#import "NSDate+Day.h"
@implementation TTWeatherItemTest
-(void) testEqual{
    TTWeatherItem *item1 = [TTWeatherItem new];
    TTWeatherItem *item3 =[TTWeatherItem new];
    TTWeatherItem *item4 =[TTWeatherItem new];
    NSString *testString = @"Test string";
    
    NSDate *nowDate = [NSDate date];
    item1.date = nowDate;
    item3.date = [nowDate dateByAddingTimeInterval:10];
    item4.date = [nowDate dateByAddingTimeInterval:60*60*24];
    
    STAssertTrue([item1 isEqual:item1], @"Same");
    STAssertTrue([item1 isEqual:[nowDate endOfDay]], @"Items  equal");
    STAssertTrue([item1 isEqual:item3], @"Items equal");
    STAssertFalse([item1 isEqual:item4], @"Items not equal");
    STAssertFalse([item1 isEqual:testString], @"Items not equal");
}
@end
