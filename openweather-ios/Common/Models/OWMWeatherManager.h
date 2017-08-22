//
//  OWMWeatherManager.h
//  openweather-ios
//
//  Created by Harry Singh on 20/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
@class OWMWeather;

@protocol OWMWeatherManagerProtocol
-(void)didAddWeather:(OWMWeather * _Nonnull)weather atIndex:(NSUInteger)index;
-(void)didRemoveWeather:(OWMWeather * _Nonnull)weather atIndex:(NSUInteger)index;
@end

@interface OWMWeatherManager : NSObject
@property (weak, nonatomic, nullable) id<OWMWeatherManagerProtocol> delegate;
@property (readonly, nonatomic, nullable) OWMWeather *locationBasedWeather;

-(NSUInteger)weatherCount;
-(OWMWeather * _Nullable)weatherAtIndex:(NSUInteger)index;

+(instancetype _Nonnull)manager;
-(void)addWeather:(OWMWeather * _Nonnull)weather;
-(void)removeWeather:(OWMWeather * _Nonnull)weather;
@end
