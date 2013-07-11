//
//  TTWeatherItem.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTWeatherItem.h"
#import "NSDate+Day.h"
@implementation TTWeatherItem
-(BOOL) isEqual:(id)object{
    NSDate *compareDate=nil;
    if ([object isKindOfClass:[TTWeatherItem class]]) {
        TTWeatherItem *item = object;
        compareDate = item.date;
    }
    if ([object isKindOfClass:[NSDate class]]) {
        compareDate = object;
    }
    if ((compareDate==nil)||(self.date==nil)) {
        return NO;
    }
    return [[compareDate  begginOfDay] isEqual:[self.date begginOfDay]];
    
}

-(id) init{
    self= [super init];
    if (self) {
        self.temp = TTWEATHER_TEMP_NONE;
        self.tempHigh = TTWEATHER_TEMP_NONE;
        self.tempLow = TTWEATHER_TEMP_NONE;
        self.text = @"";
        self.date = nil;
    }
    return self;
}

-(NSString *)description{
    return [NSString stringWithFormat:@"Weather:\n"
            "\ttemp - %i\n"
            "\tlow-%i\n"
            "\thig-%i\n"
            "\ttext-%@\n"
            "\tdate-%@\n",self.temp,self.tempLow,self.tempHigh,self.text,self.date];
}
@end
