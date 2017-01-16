//
//  Geographic_AppTests.m
//  Geographic AppTests
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "Geographic_AppTests.h"
#import <sqlite3.h>


@implementation Geographic_AppTests

- (void)setUp
{
    [super setUp];
    NSLog(@"Hacemos el set up");
    miJuego = [[VCJuego alloc] init];
    VCPais * elPais = [[VCPais alloc] initWithName:@"pais de prueba"];
    VCRegion * laRegion = [[VCRegion alloc]initWithName:@"region de prueba 1"];
    CGPoint ubicacion;
    ubicacion.x=200;
    ubicacion.y=350;
    laRegion.ubicacion=ubicacion;
    ubicacion.x=100;
    ubicacion.y=430;
    laRegion.ubicacionInicial=ubicacion;
    [elPais anadirRegion:laRegion];
    laRegion = [[VCRegion alloc]initWithName:@"region de prueba 2"];
    ubicacion.x=300;
    ubicacion.y=550;
    laRegion.ubicacion=ubicacion;
    ubicacion.x=200;
    ubicacion.y=530;
    laRegion.ubicacionInicial=ubicacion;
    [elPais anadirRegion:laRegion];
    miJuego.pais=elPais;
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testExample
{
    //STFail(@"Unit tests are not implemented yet in Geographic AppTests");
}

/*
 * Test para comprobar que: 
 * 1. el juego inicializado no devuelva nil
 * 2. el tiempo total sin terminar el juego no puede ser distinto de -1
 * 3. el tiempo total es correcto al terminar al juego
 */
- (void)testTiempo
{
    
    STAssertNotNil(miJuego, @"Al inicializar el juego está devolviendo nil");
    
    [miJuego empezar];
    STAssertTrue(-1==[miJuego tiempoTotal], @"El tiempo total sin terminar el juego es erróneo");
    
    sleep(10);
    [miJuego terminar];
    STAssertTrue([miJuego tiempoTotal]==10, @"El tiempo de juego es erróneo");
}

/*
 * Comprueba si detecta correctamente cuando todas las regiones están bien colocadas y, por tanto,
 * la partida debe terminar
 */
-(void)testUbicacion
{
    STAssertFalse([miJuego todasColocadas], @"Las regiones todavía no están colocadas");
}

/*
 * Test que comprueba si los datos del ranking local se almacenan correctamente en la base de datos
 */
-(void)testPersistencia
{
    sqlite3 * Conexion=NULL;
    NSString * rutasqlite=[NSHomeDirectory() stringByAppendingPathComponent:@"Library/geoapp.sqlite"];
    sqlite3_open([rutasqlite UTF8String], &Conexion);
    
    //Ejecuta la conexión con la consulta para eliminar los registros de la tabla
    const char consulta[]="DELETE FROM ranking";
    char * error = NULL;
    sqlite3_exec(Conexion, consulta, NULL, NULL, &error);
    //Comienza el juego y termina tras 2 segundos
    [miJuego empezar];
    sleep(2);
    [miJuego terminar];
    //Se almacenan los datos del juego en el ranking local
    [miJuego persistir];
    //Comprueba que se ha almacenado algún registro y que sea sólo uno
    const char consulta2[]="SELECT COUNT (*) FROM ranking";
    sqlite3_stmt * sentencia;
    sqlite3_prepare_v2(Conexion, consulta2, -1, &sentencia, NULL);
    STAssertTrue(SQLITE_ROW==sqlite3_step(sentencia), @"La consulta no ha dado ningún registro");
    STAssertTrue(sqlite3_column_int(sentencia, 0)==1, @"Debería haber un registro guardado");

}

@end
