//
//  OWMThreeHourCell.h
//  openweather-ios
//
//  Created by Harry Singh on 22/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class OWMForecast;

@interface OWMThreeHourCell : UICollectionViewCell

-(void)setForecast:(OWMForecast *)forecast;
@end
