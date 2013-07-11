//
//  NSDate+Day.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "NSDate+Day.h"

@implementation NSDate (Day)
-(NSDate *)begginOfDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit|NSYearCalendarUnit|
                                                         NSDayCalendarUnit|
                                                         NSHourCalendarUnit |NSMinuteCalendarUnit|
                                                         NSSecondCalendarUnit )
                                               fromDate:self];
    
    [components setHour:0];
    [components setMinute:0];
    [components setSecond:0];
    
    return [calendar dateFromComponents:components];
    
}

-(NSDate *)endOfDay{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:(NSMonthCalendarUnit|NSYearCalendarUnit|
                                                         NSDayCalendarUnit|
                                                         NSHourCalendarUnit |NSMinuteCalendarUnit|
                                                         NSSecondCalendarUnit)
                                               fromDate:self];
    [components setHour:23];
    [components setMinute:59];
    [components setSecond:59];
    
    return [calendar dateFromComponents:components];
}

+(NSDate*) dateFromForecastString:(NSString*)strDate timeZone:(NSString*) timeZone{
    /*date: the date to which this forecast applies. The date is in "dd Mmm yyyy" format, for example "30 Nov 2005" (string)*/
    if ([strDate length]==0) {
        return nil;
    }
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"dd MMM yyyy"];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSTimeZone *tz = nil;
    if (timeZone) {
        tz = [NSTimeZone timeZoneWithAbbreviation:timeZone];
    }else{
        tz = [NSTimeZone defaultTimeZone];
    }
 
    [dateFormat setTimeZone:tz];
    
    NSDate *date = [dateFormat dateFromString:strDate];
    return date;
}

+(NSDate*) dateFromConditionString:(NSString*)strDate{
    /*date: the current date and time for which this forecast applies. The date is in RFC822 Section 5 format, for example "Wed, 30 Nov 2005 1:56 pm PST
     Tue, 09 Jul 2013 5:58 pm EEST"
     
     */
    if ([strDate length]==0) {
        return nil;
    }
    
    // Search from back to get the last space character
    NSRange range= [strDate rangeOfString: @" " options: NSBackwardsSearch];
    
    // take the second substring: from after the space to the end of the string
    NSString* timeZone= [strDate substringFromIndex: range.location+1];  // @"sentence"
    
    // Take the first substring: from 0 to the space character
    strDate= [strDate substringToIndex: range.location]; 
    
    
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    dateFormat.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    [dateFormat setDateFormat:@"EEE, dd MMM yyyy h:mm a"];
    NSTimeZone *tz = [NSTimeZone timeZoneWithAbbreviation:timeZone];
    [dateFormat setTimeZone:tz];
    NSDate *date = [dateFormat dateFromString:strDate];
    return date;
}

-(NSString*) stringRepresentation{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setLocale:[NSLocale currentLocale]];
    [dateFormat setDateStyle:NSDateFormatterFullStyle];
    NSString *str = [dateFormat stringFromDate:self];
    return str;
}

@end
