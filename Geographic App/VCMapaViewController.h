//
//  VCMapaViewController.h
//  Geographic App
//
//  Created by Verónica Cordobés on 26/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCJuego.h"

@interface VCMapaViewController : UIViewController<UIGestureRecognizerDelegate,UIAlertViewDelegate>{
IBOutlet UIImageView * imagenPais;
    IBOutlet UILabel * etiquetaPais;
    
}


@property IBOutlet UIImageView * imagenPais;
@property VCJuego * juego;

-(IBAction) volver;
-(void) inicializar;

@end
