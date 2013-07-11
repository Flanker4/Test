//
//  TTYahooRSSParserTest.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTYahooRSSParserTest.h"
#import "TTYahooRSSParser.h"
@implementation TTYahooRSSParserTest
-(void)setUp{
    [super setUp];
    self.parser = [[TTYahooRSSParser alloc] init];
}
-(void)tearDown{
     self.parser = nil;
    [super tearDown];

}

-(void) testRealData{
    
    NSURL *url = [NSURL URLWithString:@"http://weather.yahooapis.com/forecastrss?w=919163&u=c"];
    NSData * xmlData = [NSData dataWithContentsOfURL:url];
    STAssertNotNil(xmlData, @"");
    
    NSArray *weatherItems =  [self.parser parseWeatherData:xmlData];
    STAssertNotNil(weatherItems, @"");
    STAssertTrue((weatherItems.count!=0), @"Expexted items");
}

-(void) testPreloadedData{
    NSString *path = [[NSBundle mainBundle] pathForResource:@"rss" ofType:@"test"];
    NSData *data = [NSData dataWithContentsOfFile:path];
    STAssertNotNil(data, @"");
    
    NSArray *weatherItems =  [self.parser parseWeatherData:data];
    STAssertNotNil(weatherItems, @"");
    STAssertEquals((int)[weatherItems count], 2, @"Expexted two items");
}
@end
