//
//  TTWeatherService.h
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import <Foundation/Foundation.h>
@interface TTYahooWeatherService : NSObject
-(void) requestWeatherForCity:(TTCity*) city
                    failBlock:(void (^)(NSError*)) failCallback;


-(BOOL) processData:(NSData*)data;
@end
