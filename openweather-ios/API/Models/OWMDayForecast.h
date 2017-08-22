//
//  OWMDayForecast.h
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface OWMDayForecast : NSObject
@property (readonly, nonatomic) NSNumber *min;
@property (readonly, nonatomic) NSNumber *max;
@property (readonly, nonatomic) NSString *day;
@property (readonly, nonatomic) NSArray *forecast;
@property (readonly, nonatomic) NSDate *date;

-(instancetype _Nullable)initWithDate:(NSDate *)date andDaysForecast:(NSArray *)forecast;
@end
