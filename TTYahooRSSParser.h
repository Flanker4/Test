//
//  TTYahooRSSParser.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTYahooRSSParser : NSObject<NSXMLParserDelegate>

-(NSArray*) parseWeatherData:(NSData*)data;

@end
