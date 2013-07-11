//
//  TTViewController.m
//  DonetskWeather
//
//  Created by Boyko A.V. on 08.07.13.
//  Copyright (c) 2013 IDS Test Task. All rights reserved.
//

#import "TTViewController.h"
#import "TTAppDelegate+DataProvider.h"
#import "NSDate+Day.h"
#import "TTYahooWeatherService.h"
#import <QuartzCore/QuartzCore.h>

@interface TTViewController (){
    IBOutlet UILabel *_lblDateNow;
    IBOutlet UILabel *_lblTemp;
    IBOutlet UILabel *_lblText;
    IBOutlet UILabel *_lblTempTomorow;
    IBOutlet UILabel *_lblTextTomorow;
    IBOutlet UIActivityIndicatorView *_acToday;
    IBOutlet UIActivityIndicatorView *_acTomorow;
    IBOutlet UIView *_viewToday;
    IBOutlet UIView *_viewTomorow;
    TTYahooWeatherService *_service;
}
-(void) updateData;
@end

@implementation TTViewController

- (void)viewDidLoad{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    //move to init
    _viewToday.layer.cornerRadius = 5;
    _viewTomorow.layer.cornerRadius = 5;
    
    
    _service = [TTYahooWeatherService new];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(update:) name:kTTNotificationDataUpdated object:nil];
    
    
    [self updateData];
    [self updateView];
    
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self requestUpdate];
    
}

-(void) dealloc{
     [[NSNotificationCenter defaultCenter] removeObserver:self name:kTTNotificationDataUpdated object:nil];
}

- (void)didReceiveMemoryWarning{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//
// MARK: - fill data
//

-(void) update:(NSNotification*)notification{
    if ([[notification name] isEqualToString:kTTNotificationDataUpdated]){
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateData];
            [self updateView];            
        });
    }
}

-(void) updateView{
    //today
    if (self.todayWeather) {
         _lblTemp.text = self.todayWeather.temperature;
        _lblText.text = self.todayWeather.text;
        _lblDateNow.text = [self.todayWeather.date stringRepresentation];
        [_acToday stopAnimating];
        _lblTemp.hidden = NO;
        _lblText.hidden = NO;
        _lblDateNow.hidden = NO;
    }else{
        [_acToday startAnimating];
        _lblTemp.hidden = YES;
        _lblText.hidden = YES;
        _lblDateNow.hidden = YES;


    }
    
    //tomorow
    if (self.tomorrowWeather) {
        _lblTempTomorow.text = self.tomorrowWeather.temperature;
        _lblTextTomorow.text = self.tomorrowWeather.text;
        [_acTomorow stopAnimating];
        _lblTempTomorow.hidden = NO;
        _lblTextTomorow.hidden = NO;
    }else{
        [_acTomorow startAnimating];
        _lblTempTomorow.hidden = YES;
        _lblTextTomorow.hidden = YES;
    }


}

-(void) updateData{
    TTAppDelegate *dataProvider = ((TTAppDelegate*)[UIApplication sharedApplication].delegate);
    NSDate *nowDate = [NSDate date];
    self.todayWeather =[dataProvider weatherForDay:nowDate];
    NSDate *tomorowDate = [nowDate dateByAddingTimeInterval:60*60*24];
    self.tomorrowWeather = [dataProvider weatherForDay:tomorowDate];
}

-(void) requestUpdate{
    self.todayWeather = nil;
    self.tomorrowWeather = nil;
    [self updateView];
    TTAppDelegate *dataProvider = [[UIApplication sharedApplication] delegate];
    [_service requestWeatherForCity:dataProvider.donetsk failBlock:^(NSError *er) {
        NSLog(@"");
    }];
}


//
// MARK: - User interaction
//
- (IBAction)pressShowInfo:(id)sender{
    NSString *text = @"Photo: http://all-ukraine.livejournal.com/271777.html\n"
                     @"Service: Yahoo! Weather\n"
                     @"Author: Boyko A.V.\n";
    UIAlertView *av = [[UIAlertView alloc] initWithTitle:nil message:text delegate:nil cancelButtonTitle:@"ok" otherButtonTitles: nil];
    [av show];
}

- (IBAction)pressUpdate:(id)sender {
    [self requestUpdate];
    
}

@end
