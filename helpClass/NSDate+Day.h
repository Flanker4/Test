//
//  NSDate+Day.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (Day)
-(NSDate *)begginOfDay;
-(NSDate *)endOfDay;

/*date: the date to which this forecast applies. The date is in "dd Mmm yyyy" format, for example "30 Nov 2005" (string)*/
+(NSDate*) dateFromForecastString:(NSString*)strDate timeZone:(NSString*) timeZone;

/*date: the current date and time for which this forecast applies. The date is in RFC822 Section 5 format, for example "Wed, 30 Nov 2005 1:56 pm PST" */
+(NSDate*) dateFromConditionString:(NSString*)strDate;

-(NSString*) stringRepresentation;
@end
