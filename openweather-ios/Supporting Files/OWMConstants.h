//
//  OWMConstants.h
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kWeatherAPIBaseURL [NSURL URLWithString:@"https://api.openweathermap.org/data/2.5/"]
#define kWeatherAPIKey @"b46573c5ad07d712b3d48f93a1282bcb"
#define kKelvinToCelcius(x) x - 273.15
#define kKelvinToFahrenheit(x) x * 9.0/5.0 - 459.67
#define kWeatherIconURLString(x)  [NSString stringWithFormat:@"https://openweathermap.org/img/w/%@.png", x];

typedef enum : NSUInteger {
    TemperatureUnitCelsius,
    TemperatureUnitFahrenheit
} TemperatureUnit;

@interface OWMConstants : NSObject
+(NSString *)kelvinToDefaultTemprature:(NSNumber *)kelvin;
+(void)setTemperatureUnit:(TemperatureUnit)unit;
+(TemperatureUnit)currentUnit;
@end
