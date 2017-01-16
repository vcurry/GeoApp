//
//  VCRankingLocalViewController.h
//  Geographic App
//
//  Created by Verónica Cordobés on 23/11/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCJuego.h"
#import "VCRanking.h"

@interface VCRankingLocalViewController : UIViewController<UITableViewDataSource>{
    VCRanking * ranking;
}
@property (strong,nonatomic) VCJuego * juego;

@property (strong,nonatomic) IBOutlet UITableView * tabla;
-(IBAction)inicio:(id)sender;
-(IBAction)abrirRankingGlobal:(id)sender;
@end
