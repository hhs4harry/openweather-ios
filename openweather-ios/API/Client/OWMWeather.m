//
//  OWMWeather.m
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMWeather.h"
#import "OWMAPIClient.h"
#import "OWMConstants.h"

@interface OWMWeather()
@property (strong, nonatomic) OWMAPIClient *client;

@end

@implementation OWMWeather

+(instancetype)manager{
    static dispatch_once_t onceToken;
    static OWMWeather *sharedManager = nil;
    dispatch_once(&onceToken, ^{
        sharedManager = [self init];
    });
    
    return sharedManager;
}

-(instancetype)init{
    if (self = [super init]) {
        self.client = [[OWMAPIClient alloc] initWithBaseURL:kWeatherAPIBaseURL];
    }
    
    return self;
}

@end
