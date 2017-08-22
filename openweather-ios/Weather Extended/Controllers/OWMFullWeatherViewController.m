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
    self.currentWeatherLabel.text = @"Sunny";
    self.maxLabel.text = self.weather.todayMaxTemp;
    self.minLabel.text = self.weather.todayMinTemp;
    self.dayLabel.text = self.weather.day;
}

#pragma mark - TableView

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.fiveDayForecast.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
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
