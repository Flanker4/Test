//
//  TTDataProviderTest.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 10.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTDataProviderTest.h"
#import "TTAppDelegate+DataProvider.h"
#import "TTWeatherItem.h"
@implementation TTDataProviderTest
-(void) test1Donetsk{
    TTAppDelegate *dataProvider = (TTAppDelegate*)[UIApplication sharedApplication].delegate;
    TTCity *donetsk = dataProvider.donetsk;
    STAssertNotNil(donetsk, @"");
    STAssertEqualObjects(donetsk.idx, @"919163", @"Required city with code 919163");
}

-(void) test2AddWeather{
    TTAppDelegate *dataProvider = (TTAppDelegate*)[UIApplication sharedApplication].delegate;
   
    NSDate *now = [NSDate date];
    
    //first
    TTWeatherItem *newWeatherItem = [TTWeatherItem new];
    newWeatherItem.text = @"Test Text";
    newWeatherItem.date = now;
    [dataProvider addWeatherItem:@[newWeatherItem]];

    TTWeather *weather = [dataProvider weatherForDay:now];
    STAssertEqualObjects(weather.text, @"Test Text", @"Object must be equal");
    
    
    
    newWeatherItem = [TTWeatherItem new];
    newWeatherItem.text = @"Test Text 2";
    newWeatherItem.date = [NSDate dateWithTimeInterval:10 sinceDate:now];
    [dataProvider addWeatherItem:@[newWeatherItem]];
    weather = [dataProvider weatherForDay:now];
    STAssertEqualObjects(weather.text, @"Test Text 2", @"Object must be equal");
    
    
    newWeatherItem = [TTWeatherItem new];
    newWeatherItem.text = @"Next day";
    newWeatherItem.date = [NSDate dateWithTimeInterval:60*60*24 sinceDate:now];
    [dataProvider addWeatherItem:@[newWeatherItem]];
    weather = [dataProvider weatherForDay:newWeatherItem.date];
    STAssertEqualObjects(weather.text, @"Next day", @"Object must be equal");
    
}
@end
