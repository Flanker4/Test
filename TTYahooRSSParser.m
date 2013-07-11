//
//  TTYahooRSSParser.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTYahooRSSParser.h"
#import "TTAppDelegate.h"
#import "TTWeatherItem.h"
#import "NSDate+Day.h"
//In .h file


//In .m file
NSString *const kWeatherDate = @"date";
NSString *const kWeatherTemperature = @"temp";
NSString *const kWeatheLow = @"low";
NSString *const kWeatherHight = @"high";
NSString *const kWeatherText = @"text";
NSString *const kWeatherCode = @"code";



@interface TTYahooRSSParser(){
    NSString *_currentTimeZone;
    NSMutableArray * _weatherItems;
    NSXMLParser *_parser;
}
@end


@implementation TTYahooRSSParser



-(NSArray*) parseWeatherData:(NSData*)data{
    _parser = nil;
    _weatherItems = nil;
    _currentTimeZone = nil;
    NSString* xml = [[NSString alloc] initWithData:data
                                          encoding:NSUTF8StringEncoding];
    NSLog(@"%@",xml);
    
    _parser = [[NSXMLParser alloc] initWithData:[xml dataUsingEncoding:NSUTF8StringEncoding]];
    _parser.delegate = self;
    _weatherItems = [NSMutableArray    arrayWithCapacity:2];
    BOOL success = [_parser parse];
    if(success){
        return [NSArray arrayWithArray:_weatherItems];
    }
    return nil;
}

-(void) parser:(NSXMLParser *)parser
didStartElement:(NSString *)elementName
  namespaceURI:(NSString *)namespaceURI
 qualifiedName:(NSString *)qName
    attributes:(NSDictionary *)attributeDict
{
    if ([elementName isEqualToString:@"yweather:forecast"]) {
        [self parseForecast:attributeDict];
    }
    if  ([elementName isEqualToString:@"yweather:condition"]){
        [self parseCondition:attributeDict];
    }
}

-(void) parserDidEndDocument:(NSXMLParser *)parser{
    _parser = nil;
}
-(void) parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError{
    NSLog(@"ERROR: %@",[parseError description]);
}

-(void) parser:(NSXMLParser *)parser validationErrorOccurred:(NSError *)validationError{
    NSLog(@"ERROR: %@",[validationError description]);    
}


//
// MARK: - Help methods
//

-(void) parseForecast:(NSDictionary*)attributeDict{
    NSDate * date = [NSDate dateFromForecastString:attributeDict[kWeatherDate] timeZone:_currentTimeZone];
    id low = attributeDict[kWeatheLow];
    id hight = attributeDict[kWeatherHight];
    id code = attributeDict[kWeatherCode];
    id text = attributeDict[kWeatherText];
    
    //verify
    if ((date)&&(low)&&(hight)&&(code)&&(text)){
        //find TTWeatherItem with date
        NSUInteger index = [_weatherItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqual:date]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        if (index==NSNotFound) {
            //if item isn't  exist
            TTWeatherItem *newItem = [TTWeatherItem new];
            newItem.date = date;
            newItem.tempHigh = [hight integerValue];
            newItem.tempLow = [low integerValue];
            newItem.code = [code integerValue];
            newItem.text = text;
            [_weatherItems addObject:newItem];
        }
        //if item exist, don't edit
    }
    

}

-(void) parseCondition:(NSDictionary*)attributeDict{
    
    NSString *strDate = attributeDict[kWeatherDate];
    NSDate * date = [NSDate dateFromConditionString:strDate];
    
    //save current timezone
    NSRange range= [strDate rangeOfString: @" " options: NSBackwardsSearch];
    _currentTimeZone= [strDate substringFromIndex: range.location+1];  // @"sentence"
    
    
    
    id code = attributeDict[kWeatherCode];
    id text = attributeDict[kWeatherText];
    id temp = attributeDict[kWeatherTemperature];
    //verify
    if ((date)&&(temp)&&(code)&&(text)){
        //find TTWeatherItem with date
        NSUInteger index = [_weatherItems indexOfObjectPassingTest:^BOOL(id obj, NSUInteger idx, BOOL *stop) {
            if ([obj isEqual:date]) {
                *stop = YES;
                return YES;
            }
            return NO;
        }];
        
        TTWeatherItem *item = nil;
        if (index==NSNotFound) {
            item = [TTWeatherItem new];
        }else{
            item = _weatherItems[index];
        }
    
        //if item isn't  exist
        item.date = date;
        item.temp = [temp integerValue];
        item.code = [code integerValue];
        item.text = text;
        if (index==NSNotFound) {
            [_weatherItems addObject:item];
        }
    }
}
@end
