//
//  OWMSearchViewController.m
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMSearchViewController.h"
#import "OWMSearchResultCell.h"
#import "OWMLocation.h"
#import "OWMWeather.h"
#import "OWMWeatherManager.h"
@import MapKit;

@interface OWMSearchViewController () <UISearchBarDelegate, OWMLocationProtocol>
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray<MKLocalSearchCompletion *> * results;
@end

@implementation OWMSearchViewController

-(void)awakeFromNib{
    [super awakeFromNib];
    
    [OWMLocation manager].delegate = self;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    self.title = @"Search";
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"close"] style:UIBarButtonItemStylePlain target:self action:@selector(backBarButtonTouchUpInside:)];
    [backItem setTintColor:[UIColor whiteColor]];
    self.navigationItem.rightBarButtonItem = backItem;
    self.navigationItem.hidesBackButton = YES;
}

-(void)backBarButtonTouchUpInside:(id)sender{
    CATransition* transition = [CATransition animation];
    transition.duration = 0.4;
    transition.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    transition.type = kCATransitionReveal;
    transition.subtype = kCATransitionFromBottom;
    [self.navigationController.view.layer addAnimation:transition forKey:nil];
    [self.navigationController popViewControllerAnimated:NO];
}

#pragma mark - SearchBar Delegate

-(void)searchBarTextDidEndEditing:(UISearchBar *)searchBar{
    if (!searchBar.text.length) {
        return;
    }
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
}

- (BOOL)searchBar:(UISearchBar *)searchBar shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    
    [[OWMLocation manager] searchLocation:searchBar.text];
    return YES;
}

#pragma mark - TableView

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.results.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    OWMSearchResultCell *cell = [tableView dequeueReusableCellWithIdentifier:@"searchResultCell" forIndexPath:indexPath];
    MKLocalSearchCompletion *result = [self.results objectAtIndex:indexPath.item];
    NSMutableAttributedString *location = [[NSMutableAttributedString alloc] initWithString:result.title attributes:@{ NSForegroundColorAttributeName : [UIColor lightGrayColor] }];
    [location addAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] } range:[result.title rangeOfString:self.searchBar.text]];
    cell.locationLabel.attributedText = location;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    MKLocalSearchCompletion *location = [self.results objectAtIndex:indexPath.item];
    
    __weak typeof(self) wself = self;
    [[OWMLocation manager] revergeGeocodeAddress:location.title withCompletion:^(CLPlacemark *placemark) {
        if (placemark) {
            OWMWeather *weather = [[OWMWeather alloc] initWithPlacemark:placemark];
            [[OWMWeatherManager manager] addWeather:weather];
            
            [wself backBarButtonTouchUpInside:self];
        }
    }];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    [self.searchBar resignFirstResponder];
}

#pragma mark - OWNLocationProtocol

-(void)searchResults:(NSArray<MKLocalSearchCompletion *> *)results{
    self.results = results;
    [self.tableView reloadData];
}

@end
