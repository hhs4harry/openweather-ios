//
//  OWMWeatherSummaryCell.m
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMWeatherSummaryCell.h"
#import "OWMWeather.h"
#import "OWMWeatherData.h"
#import "OWMCity.h"
#import "OWMForecast.h"
#import "OWMMain.h"
#import "OWMToday.h"
#import "OWMWeatherForecast.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OWMWeatherSummaryCell() <OWMWeatherProtocol>
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *weatherLabel;
@property (strong, nonatomic) OWMWeather *weather;
@end

@implementation OWMWeatherSummaryCell

-(void)configureWithWeather:(OWMWeather *)weather{
    if (weather) {
        self.weather = weather;
    }
    
    [self updateInfo];
}

-(void)updateInfo{
    if (self.weather) {
        self.weather.delegate = self;
        self.cityLabel.text = self.weather.city;
        self.weatherLabel.text = self.weather.currentTemp;
        
        OWMWeatherForecast *wfc = self.weather.today.weather.firstObject;
        if (wfc && wfc.icon) {
            [self.weatherImageView sd_setImageWithURL:[NSURL URLWithString:wfc.icon]];
        }
    }
}

-(void)didUpdateTodaysWeather:(OWMToday *)today{
    [self updateInfo];
}
@end
