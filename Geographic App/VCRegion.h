//
//  VCRegion.h
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VCRegion : NSObject

@property (copy,nonatomic) NSString * nombre;
@property (copy,nonatomic) NSString * nombreImagen;
@property (strong,nonatomic) UIImage * imagen;
@property (assign,nonatomic) CGPoint ubicacion;
@property (assign,nonatomic) CGPoint ubicacionInicial;

-(id)initWithName:(NSString *) nombre;

@end
