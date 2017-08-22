//
//  OWMWeatherManager.m
//  openweather-ios
//
//  Created by Harry Singh on 20/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMWeatherManager.h"
#import "OWMWeather.h"

NSString * const kOWMWeatherManagerEncodeDecodeWeather = @"com.owm.manager.weather.encode.decode";

@interface OWMWeatherManager()
@property (strong, nonatomic) NSMutableArray<OWMWeather *> *weathers;
@property (strong, nonatomic) OWMWeather *locationBasedWeather;
@end

@implementation OWMWeatherManager

+(instancetype)manager{
    static dispatch_once_t onceToken;
    static OWMWeatherManager *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });

    return sharedManager;
}

-(instancetype)init{
    if (self = [super init]) {
        [self unarchiveServers];

        if (!self.weathers) {
            self.weathers = [[NSMutableArray alloc] init];
        }
    }
    
    return self;
}

#pragma mark - Encode / Decode

-(void)unarchiveServers{
    NSData *weatherData = [[NSUserDefaults standardUserDefaults] objectForKey:kOWMWeatherManagerEncodeDecodeWeather];
    self.weathers = [NSKeyedUnarchiver unarchiveObjectWithData:weatherData];
}

-(void)archiveWeather{
    NSData *weatherData = [NSKeyedArchiver archivedDataWithRootObject:self.weathers];
    [[NSUserDefaults standardUserDefaults] setObject:weatherData forKey:kOWMWeatherManagerEncodeDecodeWeather];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

-(void)addWeather:(OWMWeather *)weather{
    if (weather && ![self.weathers containsObject:weather]) {
        if (weather.type == WeatherTypeLocation) {
            [self.weathers insertObject:weather atIndex:0];
            [self fireDidAddWeather:weather atIndex:0];
        } else {
            [self.weathers addObject:weather];
            NSInteger index = [self.weathers indexOfObject:weather];
            
            [self fireDidAddWeather:weather atIndex:index];
        }
        
        [self archiveWeather];
    }
}

-(void)removeWeather:(OWMWeather *)weather{
    if (weather && [self.weathers containsObject:weather]) {
        NSInteger index = [self.weathers indexOfObject:weather];
        [self.weathers removeObject:weather];
        
        [self fireDidRemoveWeather:weather atIndex:index];
        
        [self archiveWeather];
    }
}

-(NSUInteger)weatherCount{
    return self.weathers.count;
}

-(OWMWeather *)weatherAtIndex:(NSUInteger)index{
    if (index > self.weathers.count-1) {
        return nil;
    }
    
    return [self.weathers objectAtIndex:index];
}

-(OWMWeather * _Nullable)locationBasedWeather{
    if (_locationBasedWeather) {
        return _locationBasedWeather;
    }
    
    if (!self.weathers || !self.weathers.count) {
        return nil;
    }
    
    for (OWMWeather *weather in self.weathers) {
        if (weather.type == WeatherTypeLocation) {
            _locationBasedWeather = weather;
            break;
        }
    }
    
    return _locationBasedWeather;
}

#pragma mark - FireDelegate

-(void)fireDidAddWeather:(OWMWeather *)weather atIndex:(NSUInteger)index{
    if (self.delegate && [((NSObject *) self.delegate) respondsToSelector:@selector(didAddWeather:atIndex:)]) {
        [self.delegate didAddWeather:weather atIndex:index];
    }
}

-(void)fireDidRemoveWeather:(OWMWeather *)weather atIndex:(NSUInteger)index{
    if (self.delegate && [((NSObject *) self.delegate) respondsToSelector:@selector(didRemoveWeather:atIndex:)]) {
        [self.delegate didRemoveWeather:weather atIndex:index];
    }
}
@end
