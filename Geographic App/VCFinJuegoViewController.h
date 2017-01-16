//
//  VCFinJuegoViewController.h
//  Geographic App
//
//  Created by Verónica Cordobés on 16/11/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VCJuego.h"

@interface VCFinJuegoViewController : UIViewController<UITextFieldDelegate>{
    
}

@property (strong,nonatomic) VCJuego * juego;
@property (strong, nonatomic) IBOutlet UITextField * etiquetaNombre;

-(IBAction) guardarNombre:(id) sender;
-(IBAction) ocultarTeclado:(id) sender;

@end
