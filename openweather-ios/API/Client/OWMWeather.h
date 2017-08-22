//
//  OWMWeather.h
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWMWeather;
@class CLPlacemark;
@class OWMWeatherData;
@class OWMToday;
@class OWMDayForecast;

@protocol OWMWeatherProtocol

@optional
-(void)didUpdateForecaset:(OWMWeather * _Nonnull)weather;
-(void)didUpdateTodaysWeather:(OWMToday * _Nonnull)today;
-(void)failedToUpdateForecast:(NSError * _Nonnull)error;
@end

@interface OWMWeather : NSObject
@property (readonly, nonatomic, nullable) OWMWeatherData *weather;
@property (readonly, nonatomic, nullable) OWMToday *today;

@property (readonly, nonatomic) CLPlacemark * _Nonnull placemark;
@property (weak, nonatomic, nullable) id<OWMWeatherProtocol> delegate;

-(instancetype _Nullable)initWithPlacemark:(CLPlacemark * _Nonnull)placemark;

-(NSArray<OWMDayForecast *> * _Nullable)fiveDayForecast;
-(NSArray * _Nullable)forecastForDate:(NSDate * _Nonnull)date;
-(NSString * _Nonnull)city;
-(NSString * _Nonnull)currentTemp;
-(NSString * _Nonnull)todayMinTemp;
-(NSString * _Nonnull)todayMaxTemp;
-(NSString * _Nonnull)day;
@end
