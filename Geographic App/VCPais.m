//
//  VCPais.m
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCPais.h"

@implementation VCPais

@synthesize nombre=nombre,nombreImagen=nombreImagen,imagen=imagen,regiones=regiones;

/*
 * Inicializamos el objeto país con su nombre
 */
-(id)initWithName:(NSString * )_nombre{
    self=[super init];
    if(self){
        self.nombre=_nombre;
        self.nombreImagen=nil;
        self.imagen=nil;
        self->regiones=[NSMutableArray array];
    }
    return self;
}

/*
 * Método para añadir las regiones del país
 */
-(void)anadirRegion:(VCRegion *)region{
    [(NSMutableArray *) self->regiones addObject:region];
}


@end
