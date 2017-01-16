//
//  VCPlaneta.h
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "VCPais.h"
@class VCPlaneta;

@protocol VCPlanetaDelegate <NSObject>

-(void) planetaCargado:(VCPlaneta *) planeta;

@end

@interface VCPlaneta : NSObject <NSXMLParserDelegate>{
    @private
    VCPais * pais;
}

@property (strong,readonly,nonatomic) NSArray * paises;
@property (strong,nonatomic) id<VCPlanetaDelegate> delegado;

+(VCPlaneta *)instancia;
-(void) anadirPais:(VCPais *) pais;
-(void) cargarXML:(NSString *) ruta;

@end
