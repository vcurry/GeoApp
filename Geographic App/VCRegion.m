//
//  VCRegion.m
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCRegion.h"

@implementation VCRegion

@synthesize nombre=nombre,nombreImagen=nombreImagen,imagen=imagen,ubicacion=ubicacion,ubicacionInicial=ubicacionInicial;

/*
 * Inicializamos el objeto región con su nombre
 */
-(id)initWithName:(NSString *) _nombre{
    self=[super init];
    //Guarda la ubicación como estructura CGPoint, con coordenadas x e y
    CGPoint ubicacionAux={0.f,0.f};
    
    if(self){
        self.nombre=_nombre;
        self.nombreImagen=nil;
        self.imagen=nil;
        self.ubicacion=ubicacionAux;
        self.ubicacionInicial=ubicacionAux;
    }
    return self;
}

@end
