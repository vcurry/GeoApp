//
//  VCRanking.m
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCRanking.h"

@implementation VCRanking

@synthesize puntuaciones=puntuaciones;

/*
 * Inicializamos el objeto ranking
 */
-(id) init{
    self=[super init];
    if (self){
        self->puntuaciones=[NSMutableArray array];
    }
    return self;
}

/*
 * Método para añadir puntuaciones al ranking
 */
-(void) anadirPuntuacion: (VCPuntuacion *) puntuacion{
    [(NSMutableArray *) self->puntuaciones addObject:puntuacion];
}

/*
 * Método para listar las puntuaciones en orden ascendente
 */
-(NSArray *) getPuntuaciones{
    NSArray *sortedArray;
    sortedArray = [self->puntuaciones sortedArrayUsingComparator:^NSComparisonResult(id a, id b){
        int tiempo1 = [(VCPuntuacion *) a tiempo];
        int tiempo2 = [(VCPuntuacion *) b tiempo];
        if (tiempo1 < tiempo2) {
            return (NSComparisonResult)NSOrderedAscending;
        }else if (tiempo1 > tiempo2) {
            return (NSComparisonResult)NSOrderedDescending;
        }else{
            return (NSComparisonResult)NSOrderedSame;
        }
    }];
    return sortedArray;
}

@end
