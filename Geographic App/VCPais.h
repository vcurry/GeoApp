//
//  VCPais.h
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCRegion.h"

@interface VCPais : NSObject

@property (copy,nonatomic) NSString * nombre;
@property (copy,nonatomic) NSString * nombreImagen;
@property (strong,nonatomic) UIImage * imagen;

@property (strong,readonly,nonatomic) NSArray * regiones;

-(void)anadirRegion:(VCRegion *)region;
-(id)initWithName:(NSString * )nombre;

@end
