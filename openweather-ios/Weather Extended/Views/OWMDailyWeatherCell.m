//
//  OWMDailyWeatherCell.m
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMDailyWeatherCell.h"
#import "OWMForecast.h"
#import "OWMConstants.h"
#import "OWMMain.h"
#import "OWMDayForecast.h"

@interface OWMDailyWeatherCell()
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UIImageView *weatherImageView;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@end

@implementation OWMDailyWeatherCell

-(void)configureWithForcast:(OWMDayForecast *)forecast{
    self.dayLabel.text = forecast.day;
    self.maxLabel.text = [OWMConstants kelvinToDefaultTemprature:forecast.max];
    self.minLabel.text = [OWMConstants kelvinToDefaultTemprature:forecast.min];
}

@end
