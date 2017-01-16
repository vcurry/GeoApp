//
//  VCPuntuacion.m
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCPuntuacion.h"


@implementation VCPuntuacion

@synthesize jugador=jugador, tiempo=tiempo;

/*
 * Inicializamos el objeto jugador. El tiempo se inicia a
 * -1 porque 0 lo debemos considerar un tiempo válido
 */
-(id) init{
    self=[super init];
    if (self){
        self.jugador=nil;
        self.tiempo=-1;
    }
    return self;
}

/*
 * Método que devuelve el tiempo total tardado en terminar el juego en una cadena
 */
-(NSString *) cadenaTiempo{
    NSString * cadena;
    int segundos;
    int minutos;
    int horas;
    int tiempo;
    //Toma el tiempor total tardado en segundos
    tiempo=self.tiempo;
    //Calcula los segundos
    segundos=tiempo%60;
    tiempo=tiempo-segundos;
    //Calcula los minutos
    minutos=tiempo%3600/60;
    tiempo=tiempo-minutos*60;
    //Calcula las horas
    horas=tiempo/3600;
    //Inserta el tiempo en una cadena
    cadena=[NSString stringWithFormat:@"%2d:%2d:%2d",horas,minutos,segundos];
    cadena=[cadena stringByReplacingOccurrencesOfString:@" " withString:@"0"];
    return cadena;
}


@end
