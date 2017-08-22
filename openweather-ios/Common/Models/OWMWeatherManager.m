//
//  OWMWeatherManager.m
//  openweather-ios
//
//  Created by Harry Singh on 20/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMWeatherManager.h"
#import "OWMWeather.h"

@interface OWMWeatherManager()
@property (strong, nonatomic) NSMutableArray<OWMWeather *> *weathers;
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
        // Decode objects
        self.weathers = [[NSMutableArray alloc] init];
    }
    
    return self;
}

-(void)addWeather:(OWMWeather *)weather{
    if (weather && ![self.weathers containsObject:weather]) {
        [self.weathers addObject:weather];
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

@end
