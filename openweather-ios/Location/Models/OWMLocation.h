//
//  OWMLocation.h
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OWMPermissionProtocol.h"
@class MKLocalSearchCompletion;
@class CLPlacemark;

typedef enum : NSInteger {
    StatusUnknown = -1,
    StatusDenied,
    StatusGranted
} Status;

@protocol OWMLocationProtocol
-(void)searchResults:(NSArray<MKLocalSearchCompletion *> *)results;
@end

@interface OWMLocation : NSObject <OWMPermissionProtocol>
@property (weak, nonatomic) id<OWMLocationProtocol> delegate;
@property (assign, nonatomic) Status status;

+(instancetype)manager;
-(void)searchLocation:(NSString *)location;
-(void)revergeGeocodeAddress:(NSString *)address withCompletion:(void(^)(CLPlacemark *placemark))completion;
@end
