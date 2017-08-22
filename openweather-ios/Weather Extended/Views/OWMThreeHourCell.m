//
//  OWMThreeHourCell.m
//  openweather-ios
//
//  Created by Harry Singh on 22/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMThreeHourCell.h"
#import "OWMForecast.h"
#import "OWMMain.h"
#import "OWMConstants.h"
#import "NSDate+Helper.h"
#import "OWMWeatherForecast.h"
#import <SDWebImage/UIImageView+WebCache.h>

@interface OWMThreeHourCell()
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIImageView *forecastImageView;
@property (weak, nonatomic) IBOutlet UILabel *tempLabel;
@property (strong, nonatomic) OWMForecast *forecast;
@end

@implementation OWMThreeHourCell

-(void)configureCell{
    self.timeLabel.text = self.forecast.dt.HH12Hour;
    self.tempLabel.text = [OWMConstants kelvinToDefaultTemprature:self.forecast.main.temp];
    
    OWMWeatherForecast *wfc = self.forecast.weather.firstObject;
    if (wfc.icon) {
        [self.forecastImageView sd_setImageWithURL:[NSURL URLWithString:wfc.icon]];
    }
}

-(void)setForecast:(OWMForecast *)forecast{
    _forecast = forecast;
    
    [self configureCell];
}

@end
