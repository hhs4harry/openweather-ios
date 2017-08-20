//
//  OWMPermissionViewController.h
//  openweather-ios
//
//  Created by Harry Singh on 19/08/17.
//  Copyright © 2017 Harry Singh. All rights reserved.
//

#import "OWMBaseViewController.h"
#import "OWMPermissionProtocol.h"

@interface OWMPermissionViewController : OWMBaseViewController

-(instancetype)initWithPermission:(id<OWMPermissionProtocol>)permission;

@end
