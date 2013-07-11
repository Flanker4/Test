//
//  TTWeather.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTWeather.h"
#import "TTCity.h"
#import "NSDate+Day.h"

NSInteger const TTWEATHER_TEMP_NONE = NSIntegerMin;


@implementation TTWeather

@dynamic date;
@dynamic text;
@dynamic image;
@dynamic day;
@dynamic code;
@dynamic temp;
@dynamic tempLow;
@dynamic tempHigh;
@dynamic city;
@dynamic temperature;

-(NSString*) temperature{
    [self willAccessValueForKey:@"temp"];
    NSInteger currentTemp = [self.temp integerValue];
    [self didAccessValueForKey:@"temp"];

    if (currentTemp==TTWEATHER_TEMP_NONE){
        [self willAccessValueForKey:@"tempLow"];
        NSInteger low= [self.tempLow integerValue];
        [self didAccessValueForKey:@"tempLow"];
        
        [self willAccessValueForKey:@"tempHigh"];
        NSInteger hight= [self.tempHigh integerValue];
        [self didAccessValueForKey:@"tempHigh"];
        
        NSString *sign1 = low<0?@"-":@"+";
        NSString *sign2 = hight<0?@"-":@"+";
        
        
        return [NSString stringWithFormat:@"%@%i°C %@%i°C",sign1,low,sign2,hight];
    
    }else{
        NSString *sign = currentTemp<0?@"-":@"+";
        
        return [NSString stringWithFormat:@"%@%i°C",sign,currentTemp];
    }
}

/*+(TTWeather*) weatherWithDate:(NSDate*)date inContext:(NSManagedObjectContext*)context{
    TTWeather *weather = nil;
    
    NSDate *startDate  = [date begginOfDay];
    NSDate *endDate = [date endOfDay];

    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    fetchRequest.entity = [NSEntityDescription
                           entityForName:@"Weather" inManagedObjectContext:context];;
    fetchRequest.predicate = [NSPredicate predicateWithFormat:@"((date >= %@) AND (date <= %@))",startDate,endDate];
    
    NSError *error = nil;
    weather = [[context executeFetchRequest:fetchRequest error:&error] lastObject];
    return weather;
}*/



@end
