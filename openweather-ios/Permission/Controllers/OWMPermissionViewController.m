//
//  OWMPermissionViewController.m
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMPermissionViewController.h"

@interface OWMPermissionViewController ()
@property (weak, nonatomic) id<OWMPermissionProtocol> permission;
@end

@implementation OWMPermissionViewController

-(instancetype)initWithPermission:(id<OWMPermissionProtocol>)permission{
    NSAssert(permission != nil, @"Permission cannot be nil.");
    if (self = [super init]) {
        self.permission = permission;
        [self setupViews];
    }
    
    return self;
}

-(void)setupViews{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *permissionButton = [[UIButton alloc] init];
    permissionButton.backgroundColor = [UIColor blackColor];
    permissionButton.layer.cornerRadius = 5.0;
    [permissionButton setTitle:@"Allow Access" forState:UIControlStateNormal];
    permissionButton.translatesAutoresizingMaskIntoConstraints = NO;
    [permissionButton addTarget:self action:@selector(permissionButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:permissionButton];
    
    [[NSLayoutConstraint constraintWithItem:permissionButton attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionButton attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeBottom multiplier:1.0 constant:-10] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionButton attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeft multiplier:1.0 constant:10] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:-10] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0] setActive:YES];
    
    UILabel *permissionMessage = [[UILabel alloc] init];
    permissionMessage.textColor = [UIColor blackColor];
    permissionMessage.numberOfLines = 5;
    permissionMessage.textAlignment = NSTextAlignmentCenter;
    NSMutableAttributedString *attributesString = [[NSMutableAttributedString alloc] initWithAttributedString:self.permission.message];
    [attributesString setAttributes:@{ NSForegroundColorAttributeName : [UIColor blackColor] } range:NSMakeRange(0, attributesString.string.length)];
    [permissionMessage setAttributedText:attributesString];
    permissionMessage.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:permissionMessage];
    
    [[NSLayoutConstraint constraintWithItem:permissionMessage attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:100.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionMessage attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:permissionButton attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionMessage attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:permissionMessage attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:permissionButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0] setActive:YES];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setImage:[UIImage imageNamed:@"close"] forState:UIControlStateNormal];
    cancelButton.translatesAutoresizingMaskIntoConstraints = NO;
    [cancelButton addTarget:self action:@selector(cancelButtonTouchUpInside:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:cancelButton];
    
    [[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTop multiplier:1.0 constant:0.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeRight multiplier:1.0 constant:0.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0 constant:50.0] setActive:YES];
    [[NSLayoutConstraint constraintWithItem:cancelButton attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:cancelButton attribute:NSLayoutAttributeHeight multiplier:1.0 constant:0.0] setActive:YES];
    
    [self.view layoutIfNeeded];
}

-(void)permissionButtonTouchUpInside:(id)sender{
    UIButton *permissionButton = sender;
    permissionButton.userInteractionEnabled = NO;
    permissionButton.alpha = 0.5;
    
    __weak typeof(self) wself = self;
    [self.permission requestPermissionWithCompletion:^(Permission permission) {
        [wself dismissViewControllerAnimated:YES completion:nil];
    }];
}

-(void)cancelButtonTouchUpInside:(id)sender{
    [self dismissViewControllerAnimated:YES completion:nil];
}
@end
