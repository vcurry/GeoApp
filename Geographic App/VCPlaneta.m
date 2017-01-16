//
//  VCPlaneta.m
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCPlaneta.h"

@implementation VCPlaneta

@synthesize paises=paises, delegado=delegado;

/*
 * Instanciamos el objeto VCPlaneta. VCPlaneta es singleton, solo puede
 * haber una instancia para toda la aplicación. Esta instancia la tenemos 
 * guardada dentro de la variable estática de este método y por aquí
 * podemos obtener este objeto
 */
+(VCPlaneta *)instancia{
    static VCPlaneta * planeta=nil;
    if(planeta==nil){
        /*si es la primera vez, lo instanciamos*/
        planeta=[[VCPlaneta alloc] init];
    }
    return planeta;
}

/*
 * Inicializamos las variables del objeto VCPlaneta
 */
-(id) init{
    self=[super init];
    if(self){
        self->paises=[NSMutableArray array];
    }
    return self;
}

/*
 * Método para añadir un país al array de países
 */
-(void) anadirPais:(VCPais *) _pais{
    [(NSMutableArray *)self->paises addObject:_pais];
}

/*
 * Método para cargar el archivo XML con los datos
 */
-(void) cargarXML:(NSString *) ruta{
    NSString * rutaCompleta = [[[NSBundle mainBundle] bundlePath] stringByAppendingPathComponent:ruta];
    NSURL * URL = [NSURL fileURLWithPath:rutaCompleta];
    NSXMLParser * parser;
    parser = [[NSXMLParser alloc] initWithContentsOfURL:URL];
    parser.delegate = self;
    [parser parse];
}

/*
 * Inicializamos países como mutable array
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    self->paises=[NSMutableArray array];
}

/*
 * El parser empieza a parsear el archivo .xml
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    [delegado planetaCargado:self];
}

/*
 * Cargamos los datos encontrados en el parseo del .xml
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    //si encuentra la etiqueta país en el .xml, lo instancia y lo añade al array de países del planeta
    if([elementName isEqual: @"pais"]){
        self->pais=[[VCPais alloc] initWithName:[attributeDict valueForKey:@"nombre"]];
        NSString * nombreImagen = [attributeDict valueForKey:@"imagen"];
        self->pais.nombreImagen = nombreImagen;
        self->pais.imagen=[UIImage imageNamed:nombreImagen];
        if(self->pais.imagen ==nil){
            //NSLog(@"La imagen %@ no ha sido cargada",self->pais.nombreImagen);
            self->pais=nil;
        }else{
            [self anadirPais: self->pais];
        }
    //si encuentra la etiqueta región en el .xml, la instancia
    }else if([elementName isEqual:@"region"]){
        VCRegion * region = [[VCRegion alloc] init];
        NSString * nombre = [attributeDict valueForKey:@"nombre"];
        region.nombre=nombre;
        NSString * nombreImagen = [attributeDict valueForKey:@"imagen"];
        region.nombreImagen = nombreImagen;
        region.imagen = [UIImage imageNamed:nombreImagen];
        if(region.imagen ==nil){
            //NSLog(@"La imagen %@ no ha sido cargada",region.nombreImagen);
            region=nil;
        }
        CGPoint ubicacion;
        NSString * stringX = [attributeDict valueForKey:@"x"];
        NSString * stringY = [attributeDict valueForKey:@"y"];
        ubicacion.x = [stringX floatValue];
        ubicacion.y = [stringY floatValue];
        region.ubicacion = ubicacion;
        stringX = [attributeDict valueForKey:@"xini"];
        stringY = [attributeDict valueForKey:@"yini"];
        ubicacion.x = [stringX floatValue];
        ubicacion.y = [stringY floatValue];
        region.ubicacionInicial = ubicacion;
        //guarda la región en el array de regiones del país
        if(region!=nil){
            [self->pais anadirRegion: region];
            //NSLog(@"añadida la region %@ al país %@",region.nombre,pais.nombre);
        }

    }
}

@end
