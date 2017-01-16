//
//  VCViewController.h
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCPlaneta.h"

@interface VCViewController : UIViewController<VCPlanetaDelegate,UITableViewDelegate,UITableViewDataSource>{
    VCPlaneta * elPlaneta;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;

@end
