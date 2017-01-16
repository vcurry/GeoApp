//
//  VCPuntuacion.h
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCJugador.h"

@interface VCPuntuacion : NSObject

@property (strong,nonatomic) VCJugador * jugador;
@property (assign,nonatomic) int tiempo;

-(id) init;
-(NSString *) cadenaTiempo;

@end
