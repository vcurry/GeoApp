//
//  VCRankingGlobalViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 07/12/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCRankingGlobalViewController.h"
#import "VCAppDelegate.h"

@interface VCRankingGlobalViewController ()

@end

@implementation VCRankingGlobalViewController

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
    
    tabla.delegate=self;
    tabla.dataSource=self;
    //inicializa el ranking
    ranking=[[VCRanking alloc] init];
    
    //Guarda la petición al servidor remoto para insertar en la tabla ranking la puntuación del usuario para el país completado
    NSString * urlString=[NSString stringWithFormat:@"http://127.0.0.1:8888/?accion=insertar&pais=%@&nombre=%@&tiempo=%d",[self.juego.pais.nombre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], [self.juego.jugador.nombre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding], self.juego.tiempoTotal];
    NSURL * url=[NSURL URLWithString:urlString];
    NSLog(@"%@", urlString);
    NSURLRequest * peticion=[[NSURLRequest alloc] initWithURL:url];
    NSURLResponse * respuesta=nil;
    NSError * error=nil;
    //Guarda en dato los datos de la conexión con el servidor
    NSData * dato= [NSURLConnection sendSynchronousRequest:peticion returningResponse:&respuesta error:&error];
    //Si se obtiene un error o no hay respuesta del servidor, se muestra una alerta al usuario
    if(error!=nil || respuesta==nil){
        NSLog(@"%@",[error description]);
        [[[UIAlertView alloc] initWithTitle:@"error" message:@"no se ha podido mandar el ranking" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil] show];
    }
	//Si recibe respuesta del servidor, la trata
    if ([dato bytes]){
        NSString * mensajerespuesta=[NSString stringWithUTF8String:[dato bytes]];
        NSLog(@"%@",mensajerespuesta);
        parserinsertar=[[NSXMLParser alloc] initWithData:dato];
        parserinsertar.delegate=self;
        [parserinsertar parse];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Método para tratar los elementos encontrados al parsear
 */
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    NSLog(@"--- %@",elementName);
    [pila addObject:elementName];
    
    //si el parser es para insertar y hay algún error, se muestra una alerta al usuario
    if(parser==parserinsertar){
         if([pila isEqualToArray:@[@"error",@"codigo"]] && [(NSString *)[attributeDict valueForKey:@"valor"] intValue] !=0){
             [[[UIAlertView alloc] initWithTitle:@"error" message:@"No se ha podido insertar tu ranking" delegate:nil
                               cancelButtonTitle:@"ok" otherButtonTitles:nil] show];
         } 
    //si el parser es para listar, guardamos el nombre del jugador y el tiempo en la puntuación
    }else{
        if([pila isEqualToArray:@[@"rankings",@"ranking"]]){
            VCPuntuacion * puntuacion = [[VCPuntuacion alloc] init];
            VCJugador * jugador = [[VCJugador alloc] init];
            jugador.nombre=[attributeDict valueForKey:@"usuario"];
            puntuacion.jugador=jugador;
            puntuacion.tiempo=[(NSString *)[attributeDict valueForKey:@"tiempo"] intValue];
            [ranking anadirPuntuacion:puntuacion];
        }
    }
}

/*
 * Método para desapilar los elementos ya tratados
 */
- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    [pila removeLastObject];
}

/*
 * Método para inicializar el array mutable para guardar los elementos parseados
 */
- (void)parserDidStartDocument:(NSXMLParser *)parser{
    pila=[NSMutableArray array];
}

/*
 * Método para listar los datos necesarios almacenados en el servidor
 */
- (void)parserDidEndDocument:(NSXMLParser *)parser{
    if(parser==parserinsertar){
        NSString * urlString=[NSString stringWithFormat:@"http://127.0.0.1:8888/?accion=listar&pais=%@",[self.juego.pais.nombre stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
        NSURL * url=[NSURL URLWithString:urlString];
        parserlistar=[[NSXMLParser alloc] initWithContentsOfURL:url];
        parserlistar.delegate=self;
        [parserlistar parse];
    }else{
        NSArray * puntuaciones=[ranking getPuntuaciones];
        for(VCPuntuacion * puntuacion in puntuaciones){
            NSLog(@"nombre: %@ tiempo: %d", puntuacion.jugador.nombre, puntuacion.tiempo);
        }
        [tabla reloadData];
    }
}

/*
 * Configura la acción del botón "Inicio" para volver al menú
 */
-(IBAction)inicio:(id)sender{
    VCAppDelegate * delegado = [UIApplication sharedApplication].delegate;
    [self.navigationController popToViewController:delegado.viewController animated:YES];
}

/*
 * Método para calcular las filas de la única sección de la tabla
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return[ranking getPuntuaciones].count;
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
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section;{
    NSString * nombrePais = juego.pais.nombre;
    NSString * cadenaTitulo = [NSString stringWithFormat:@"Mejores puntuaciones de %@", nombrePais];
    return cadenaTitulo;
}

@end
