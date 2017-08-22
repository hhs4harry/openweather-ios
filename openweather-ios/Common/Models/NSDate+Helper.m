//
//  NSDate+Helper.m
//  openweather-ios
//
//  Created by Harry Singh on 22/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "NSDate+Helper.h"

@implementation NSDate (Helper)

-(NSString *)HH12Hour{
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setTimeStyle:NSDateFormatterShortStyle];
    [dateFormat setDateFormat:@"ha"];
    return [dateFormat stringFromDate:self];
}

-(NSString *)dayName{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"EEEE"];
    return [dateFormatter stringFromDate:self];
}

@end
