//
//  OWMFullWeatherViewController.m
//  openweather-ios
//
//  Created by Harry Singh on 21/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMFullWeatherViewController.h"
#import "OWMWeather.h"
#import "OWMDailyWeatherCell.h"
#import "OWMThreeHourTodayWeatherCellTableViewCell.h"

typedef enum : NSUInteger {
    SectionTypeThreeHour = 0,
    SectionTypeFiveDay,
    SectionTypeCount
} SectionType;

@interface OWMFullWeatherViewController () <OWMWeatherProtocol>
@property (strong, nonatomic) OWMWeather *weather;
@property (weak, nonatomic) IBOutlet UILabel *dayLabel;
@property (weak, nonatomic) IBOutlet UILabel *cityLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentWeatherLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentTempLabel;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *maxLabel;
@property (weak, nonatomic) IBOutlet UILabel *minLabel;
@property (strong, nonatomic) NSArray *fiveDayForecast;
@end

@implementation OWMFullWeatherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self displayTodaysWeather];
}

-(void)displayTodaysWeather{
    self.cityLabel.text = self.weather.city;
    self.currentTempLabel.text = self.weather.currentTemp;
    self.currentWeatherLabel.text = self.weather.summary;
    self.maxLabel.text = self.weather.todayMaxTemp;
    self.minLabel.text = self.weather.todayMinTemp;
    self.dayLabel.text = self.weather.day;
}

#pragma mark - TableView

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return SectionTypeCount;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == SectionTypeThreeHour) {
        return 1;
    }
    return self.fiveDayForecast.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == SectionTypeThreeHour) {
        return 100.0;
    }
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == SectionTypeThreeHour) {
        OWMThreeHourTodayWeatherCellTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"threeHourWeatherCell" forIndexPath:indexPath];
        [cell setForcasts:[self.weather forcastForRange:NSMakeRange(0, 1)]];
        return cell;
    }
    OWMDailyWeatherCell *cell = [tableView dequeueReusableCellWithIdentifier:@"dailyWeatherCell" forIndexPath:indexPath];
    [cell configureWithForcast:[self.fiveDayForecast objectAtIndex:indexPath.item]];
    return cell;
}

-(void)setWeather:(OWMWeather *)weather{
    _weather = weather;
    
    self.fiveDayForecast = [weather fiveDayForecast];
}

#pragma mark - Weather protocol

-(void)didUpdateTodaysWeather:(OWMToday *)today{
    [self displayTodaysWeather];
}

-(void)didUpdateForecaset:(OWMWeather *)weather{
    self.weather = weather;
    [self.tableView reloadData];
}

@end
