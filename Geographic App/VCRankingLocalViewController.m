//
//  VCRankingLocalViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 23/11/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCRankingLocalViewController.h"
#import "VCAppDelegate.h"
#import "VCRankingGlobalViewController.h"

@interface VCRankingLocalViewController ()

@end

@implementation VCRankingLocalViewController

@synthesize juego=juego;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //inicializa el ranking
    ranking=[[VCRanking alloc] init];
    
    //prepara la conexión con la base de datos
    sqlite3 * conexion;
    VCAppDelegate * delegado = (VCAppDelegate * ) [[UIApplication sharedApplication] delegate];
    conexion = delegado.BD;
    //crea la consulta para listar las 10 primeras puntuaciones
    NSString * consulta = [NSString stringWithFormat: @"SELECT nombre, tiempo FROM ranking WHERE pais='%@' ORDER BY tiempo LIMIT 10", self.juego.pais.nombre];
    sqlite3_stmt * resultado=NULL;
    //realiza la conexión
    sqlite3_prepare_v2(conexion, [consulta UTF8String], -1, &resultado, 0);

    //trata el resultado obtenido
    while(sqlite3_step(resultado)==SQLITE_ROW){
        //guarda el nombre del jugador y el tiempo en variables
        const unsigned char * nombre=sqlite3_column_text(resultado, 0);
        const int tiempo = sqlite3_column_int(resultado, 1);
        //crea el objeto puntuación que se añadirá al ranking
        VCPuntuacion * puntuacion = [[VCPuntuacion alloc] init];
        //añade el tiempo a la puntuación
        puntuacion.tiempo=tiempo;
        //crea el objeto jugador, que se añadirá a la puntuación
        VCJugador * jugador=[[VCJugador alloc] init];
        //transforma la variable nombre de char a NSString para añadirlo al jugador 
        jugador.nombre=[NSString stringWithFormat:@"%s",nombre];
        puntuacion.jugador=jugador;
        
        //añade la puntuación al ranking
        [ranking anadirPuntuacion:puntuacion];
        
        NSLog(@"nombre: %s tiempo:%d",nombre,tiempo);
    }

	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Método para calcular las filas de la única sección de la tabla
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self->ranking getPuntuaciones].count;
}

/*
 * Método para colocar las puntuaciones en las celdas de la tabla
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    VCPuntuacion * puntuacion=[[ranking getPuntuaciones] objectAtIndex:indexPath.row];
    UITableViewCell * celda=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    NSString * mensaje = [NSString stringWithFormat:@"%@ - %@",puntuacion.jugador.nombre,[puntuacion cadenaTiempo]];
    celda.textLabel.text=mensaje;
    return celda;
}

/*
 * Método para indicar el título de la tabla
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Ranking Local";
}

/*
 * Configura la acción del botón "Inicio" para volver al menú
 */
-(IBAction)inicio:(id)sender{
    VCAppDelegate * delegado = [UIApplication sharedApplication].delegate;
    [self.navigationController popToViewController:delegado.viewController animated:YES];
}

/*
 * Configura la acción del botón "Ranking mundial" para añadir la puntuación y listarlo
 */
-(IBAction)abrirRankingGlobal:(id)sender{
    VCRankingGlobalViewController * controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"rankingglobal"];
    controlador.juego = self.juego;
    
    [self.navigationController pushViewController:controlador animated:YES];
}

@end
