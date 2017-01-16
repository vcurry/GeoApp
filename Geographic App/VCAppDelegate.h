//
//  VCAppDelegate.h
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface VCAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIViewController * viewController;
@property (strong, nonatomic) UIWindow * window;
@property (assign, nonatomic) sqlite3* BD;

@end
