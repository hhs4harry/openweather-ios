//
//  OWMDailyWeatherCell.h
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWMDayForecast;

@interface OWMDailyWeatherCell : UITableViewCell
-(void)configureWithForcast:(OWMDayForecast *)forecast;

@end
