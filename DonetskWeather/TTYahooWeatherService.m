//
//  TTWeatherService.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 09.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTYahooWeatherService.h"
#import "TTYahooRSSParser.h"
#import "TTAppDelegate+DataProvider.h"

NSString *const SERVICE_URL = @"http://weather.yahooapis.com/forecastrss?w=%@&u=c";


@implementation TTYahooWeatherService
-(void) requestWeatherForCity:(TTCity*) city
                    failBlock:(void (^)(NSError*)) failCallback
{
    //init param
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:SERVICE_URL,city.idx]];
    NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
    NSOperationQueue *queue = [[NSOperationQueue alloc] init];

    //async request
    [NSURLConnection sendAsynchronousRequest:urlRequest
                                       queue:queue
    completionHandler:^(NSURLResponse *urlResp, NSData *data, NSError *er) {
        NSHTTPURLResponse *httpUrlResp = (NSHTTPURLResponse*) urlResp;
        if ((er)||(httpUrlResp.statusCode!=200)) {
            dispatch_async(dispatch_get_main_queue(), ^{
                failCallback(er);
            });

            return;
        }
        
        if(![self processData:data]){
            dispatch_async(dispatch_get_main_queue(), ^{
                failCallback(nil);
            });
        }
    }];
}


-(BOOL) processData:(NSData*)data{
    BOOL result = NO;
    TTYahooRSSParser *parser = [TTYahooRSSParser new];
    
    TTAppDelegate *dataProvider = ((TTAppDelegate*)[UIApplication sharedApplication].delegate);
    NSArray *array = [parser parseWeatherData:data];
    
    if (array) {
        [dataProvider addWeatherItem:array];
        result = YES;
    }

    return result;
}
@end
