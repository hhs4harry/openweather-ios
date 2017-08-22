//
//  OWMWeatherManager.h
//  openweather-ios
//
//  Created by Harry Singh on 20/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWMWeather;

@interface OWMWeatherManager : NSObject
-(NSUInteger)weatherCount;
-(OWMWeather * _Nullable)weatherAtIndex:(NSUInteger)index;

+(instancetype _Nonnull)manager;
-(void)addWeather:(OWMWeather * _Nonnull)weather;

@end
