//
//  TTDateDayTest.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTDateDayTest.h"
#import "NSDate+Day.h"
@implementation TTDateDayTest



-(void) testDateFromForecastString{
    NSString *testString = @"30 Nov 2005";
    NSDate *date = [NSDate dateFromForecastString:testString timeZone:@"EEST"];
    STAssertNotNil(date, @"Date is nil");
    
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:date];
    int year = [components year];
    STAssertEquals(year, 2005, testString);
    
    int month = [components month];
    STAssertEquals(month, 11, testString);
    
    int day = [components day];
    STAssertEquals(day, 30, testString);
    

    testString = @"9 Jul 2013";
    date = [NSDate dateFromForecastString:testString timeZone:@"EEST"];
    components = [cal components:unitFlags fromDate:date];
    year = [components year];
    STAssertEquals(year, 2013, testString);
    
    month = [components month];
    STAssertEquals(month, 7, testString);
    
    day = [components day];
    STAssertEquals(day, 9, testString);

    
}
-(void) testDateFromConditionString{
    NSString *testString = @"Wed, 30 Nov 2005 1:56 pm PST";
    NSDate *date = [NSDate dateFromConditionString:testString];
    NSCalendar *cal = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendarUnit unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *components = [cal components:unitFlags fromDate:date];
    int year = [components year];
    STAssertEquals(year, 2005, testString);
    
    int month = [components month];
    STAssertEquals(month, 11, testString);
    
    int day = [components day];
    STAssertEquals(day, 30, testString);
    
    testString = @"Tue, 09 Jul 2013 5:58 pm EEST";
    date = [NSDate dateFromConditionString:testString];
    components = [cal components:unitFlags fromDate:date];
    year = [components year];
    STAssertEquals(year, 2013, testString);
    
    month = [components month];
    STAssertEquals(month, 7, testString);
    
    day = [components day];
    STAssertEquals(day, 9, testString);

    testString =@"Thu, 11 Jul 2013 12:00 pm EEST";
    date = [NSDate dateFromConditionString:testString];
    components = [cal components:unitFlags fromDate:date];
    year = [components year];
    STAssertEquals(year, 2013, testString);
    
    month = [components month];
    STAssertEquals(month, 7, testString);
    
    day = [components day];
    STAssertEquals(day, 11, testString);
}
@end
