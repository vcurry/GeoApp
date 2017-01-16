//
//  VCRanking.h
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCPuntuacion.h"

@interface VCRanking : NSObject

@property (strong,readonly,nonatomic,getter = getPuntuaciones) NSArray * puntuaciones;

-(id) init;
-(void) anadirPuntuacion: (VCPuntuacion *) puntuacion;
-(NSArray *) getPuntuaciones;

@end
