//
//  VCJuego.h
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCJugador.h"
#import "VCPais.h"

@interface VCJuego : NSObject{
    int tiempoInicio;
    int tiempoFin;
}

@property (strong,nonatomic) VCJugador * jugador;
@property (strong,nonatomic) VCPais * pais;
@property (assign,nonatomic) int totalCorrecto;

-(id) init;
-(void) empezar;
-(void) terminar;
-(int) tiempoTotal;
-(BOOL) todasColocadas;
-(NSString *) cadenaTiempo;
-(void) persistir;
@end
