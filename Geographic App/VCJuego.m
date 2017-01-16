//
//  VCJuego.m
//  Geographic App
//
//  Created by Verónica Cordobés on 19/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//
#import <sys/time.h>
#import "VCJuego.h"
#import "VCAppDelegate.h"

@implementation VCJuego

@synthesize jugador=jugador, pais=pais, totalCorrecto=totalCorrecto;

/*
 * Inicializamos el objeto juego. Los atributos de tiempo se inicializan
 * a -1 porque 0 lo debemos considerar un tiempo válido
 */
-(id) init{
    self = [super init];
    if (self){
        self.jugador=nil;
        self.pais=nil;
        self->tiempoInicio=-1;
        self->tiempoFin=-1;
        self.totalCorrecto=0;
    }
    return self;
}

/*
 * Método para iniciar el juego. El tiempo de inicio tiene formato time
 * y el tiempo de fin continua a -1 hasta que termine el juego
 */
-(void) empezar{
    self->tiempoInicio=time(NULL);
    self->tiempoFin=-1;
}

/*
 * Método para terminar el juego y guardar el tiempo de fin 
 */
-(void) terminar{
    self->tiempoFin=time(NULL);
}

/*
 * Método para calcular el tiempo que ha tardado en completarse el juego
 * y que se calcula con la diferencia del tiempo de fin y de inicio
 */
-(int) tiempoTotal{
    if(self->tiempoFin == -1){
        return -1;
    }
    return self->tiempoFin - self->tiempoInicio;
}


/*
 * Devuelve si el número de regiones bien colocadas es igual al número de regiones
 */
-(BOOL) todasColocadas{
    return self.totalCorrecto==self.pais.regiones.count;
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
    tiempo=[self tiempoTotal];
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

/*
 * Inserta en la tabla los datos del jugador, el tiempo tardado y el país completado
 */
-(void) persistir{
    NSString * consulta= [NSString stringWithFormat:@"INSERT INTO ranking (nombre,tiempo,pais) VALUES ('%@',%d,'%@');",
                          self.jugador.nombre,[self tiempoTotal],self.pais.nombre];
    VCAppDelegate * delegado=[[UIApplication sharedApplication] delegate];
    sqlite3 * conexion=delegado.BD;
    char * error=NULL;
    sqlite3_exec(conexion, [consulta UTF8String], NULL, NULL, &error);
    
}

@end
