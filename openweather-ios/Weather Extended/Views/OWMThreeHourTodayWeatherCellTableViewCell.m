//
//  OWMThreeHourTodayWeatherCellTableViewCell.m
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMThreeHourTodayWeatherCellTableViewCell.h"
#import "OWMDayForecast.h"
#import "OWMThreeHourCell.h"

@interface OWMThreeHourTodayWeatherCellTableViewCell() <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (strong, nonatomic) NSArray *forecasts;
@property (strong, nonatomic) NSArray *threeHourForecast;

@end

@implementation OWMThreeHourTodayWeatherCellTableViewCell

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    OWMThreeHourCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"threeHourCell" forIndexPath:indexPath];
    [cell setForecast:[self.threeHourForecast objectAtIndex:indexPath.item]];
    return cell;
}

- (NSInteger)collectionView:(nonnull UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.threeHourForecast.count;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    return CGSizeMake(70.0, 100.0);
}


#pragma mark - Getters/Setters

-(void)setForcasts:(NSArray *)forcasts{
    _forecasts = forcasts;
    
    NSMutableArray *temp = [[NSMutableArray alloc] init];
    
    for (OWMDayForecast *fc in forcasts) {
        if (fc.forecast.count) {
            [temp addObjectsFromArray:fc.forecast];
        }
    }
    
    self.threeHourForecast = temp;
    
    if (self.collectionView) {
        [self.collectionView reloadData];
    }
}

@end
