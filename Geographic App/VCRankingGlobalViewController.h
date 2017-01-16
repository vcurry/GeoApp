//
//  VCRankingGlobalViewController.h
//  Geographic App
//
//  Created by Verónica Cordobés on 07/12/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCJuego.h"
#import "VCRanking.h"

@interface VCRankingGlobalViewController : UIViewController<NSXMLParserDelegate,UITableViewDelegate,UITableViewDataSource>{
    NSXMLParser * parserinsertar;
    NSXMLParser * parserlistar;
    NSMutableArray * pila;
    VCRanking * ranking;
    IBOutlet UITableView * tabla;
    IBOutlet UIButton * boton;
}

@property (strong,nonatomic) VCJuego * juego;

-(IBAction)inicio:(id)sender;

@end
