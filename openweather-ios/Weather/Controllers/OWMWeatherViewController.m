//
//  OWMWeatherViewController.m
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMWeatherViewController.h"
#import "OWMPermissionViewController.h"
#import "OWMLocation.h"
#import "OWMWeatherManager.h"
#import "OWMWeatherSummaryCell.h"
#import "OWMFullWeatherViewController.h"
#import "OWMConstants.h"
#import "OWMWeather.h"
#import "OWMLocation.h"

@interface OWMWeatherViewController () <OWMWeatherManagerProtocol>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OWMWeatherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [OWMWeatherManager manager].delegate = self;
    if ([OWMLocation manager].status == StatusGranted && ![OWMWeatherManager manager].locationBasedWeather) {
        OWMWeather *locWeather = [[OWMWeather alloc] initWithLocationManager:[[OWMLocation alloc] init]];
        [[OWMWeatherManager manager] addWeather:locWeather];
    }
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([OWMLocation manager].status == StatusUnknown) {
            [self presentViewController:[[OWMPermissionViewController alloc] initWithPermission:((id<OWMPermissionProtocol>)[OWMLocation manager])] animated:YES completion:nil];
        }
    });

    self.navigationItem.leftBarButtonItem = [self leftItem];
    
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addWeatherTouchUpInside:)];
    [searchIcon setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = searchIcon;
}

-(UIBarButtonItem *)leftItem{
    NSString *tempType;
    
    if ([OWMConstants currentUnit] != TemperatureUnitCelsius) {
        tempType = @"F°";
    } else {
        tempType = @"C°";
    }
    
    UIBarButtonItem *tempIcon = [[UIBarButtonItem alloc] initWithTitle:tempType style:UIBarButtonItemStylePlain target:self action:@selector(changeDefaultTempUnit:)];
    [tempIcon setTintColor:[UIColor whiteColor]];
    return tempIcon;
}

-(void)changeDefaultTempUnit:(id)sender{
    [OWMConstants setTemperatureUnit:[OWMConstants currentUnit] == TemperatureUnitCelsius ? TemperatureUnitFahrenheit : TemperatureUnitCelsius];
    self.navigationItem.leftBarButtonItem = [self leftItem];
    
    [self.tableView reloadData];
}

-(void)addWeatherTouchUpInside:(id)sender{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionMoveIn;
    transition.subtype = kCATransitionFromTop;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController pushViewController:[self.storyboard instantiateViewControllerWithIdentifier:@"OWMSearchViewControllerSBID"] animated:NO];
}

#pragma mark - TableView

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return [[OWMWeatherManager manager] weatherAtIndex:indexPath.row].type != WeatherTypeLocation;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView*)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath*)indexPath{
    return; //Needed for ios 8.0 to work.
}

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewRowAction *rowAction= [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDestructive title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        [[OWMWeatherManager manager] removeWeather:[[OWMWeatherManager manager] weatherAtIndex:indexPath.row]];
    }];
    
    return @[rowAction];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [OWMWeatherManager manager].weatherCount;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80.0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OWMWeatherSummaryCell *cell = (id)[tableView dequeueReusableCellWithIdentifier:@"weatherSummaryCell" forIndexPath:indexPath];
    [cell configureWithWeather:[[OWMWeatherManager manager] weatherAtIndex:indexPath.item]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(nonnull NSIndexPath *)indexPath{
    OWMFullWeatherViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"OWMFullWeatherViewControllerSBID"];
    [controller setWeather:[[OWMWeatherManager manager] weatherAtIndex:indexPath.item]];
    [self.navigationController pushViewController:controller animated:YES];
}

#pragma mark - Weather Manager Protocol

-(void)didAddWeather:(OWMWeather *)weather atIndex:(NSUInteger)index{
    [self.tableView insertRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

-(void)didRemoveWeather:(OWMWeather *)weather atIndex:(NSUInteger)index{
    [self.tableView deleteRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:index inSection:0]] withRowAnimation:UITableViewRowAnimationAutomatic];
}

@end
