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

@interface OWMWeatherViewController ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation OWMWeatherViewController

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if([OWMLocation manager].status == StatusUnknown) {
            [self presentViewController:[[OWMPermissionViewController alloc] initWithPermission:((id<OWMPermissionProtocol>)[OWMLocation manager])] animated:YES completion:nil];
        }
    });
    
    [self.tableView reloadData];
    
    UIBarButtonItem *searchIcon = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"plus"] style:UIBarButtonItemStylePlain target:self action:@selector(addWeatherTouchUpInside:)];
    [searchIcon setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = searchIcon;
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

@end
