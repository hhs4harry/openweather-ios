//
//  OWMFullWeatherViewController.h
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMBaseViewController.h"
@class OWMWeather;

@interface OWMFullWeatherViewController : OWMBaseViewController

-(void)setWeather:(OWMWeather *)weather;

@end
