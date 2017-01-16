//
//  VCViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 12/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//
#import "VCAppDelegate.h"
#import "VCViewController.h"
#import "VCMapaViewController.h"
#import "VCJuego.h"
#import <sqlite3.h>

@interface VCViewController ()

@end

@implementation VCViewController

/*
 * Inicializa el planeta y carga los datos. 
 * Establece la conexión con SQLite para crear la tabla donde se guardará el ranking en local.
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Instancia el planeta, inicializa su delegado y carga los datos de los países y regiones guardados en .xml
    VCPlaneta * planeta = [[VCPlaneta alloc] init];
    planeta.delegado = self;
    [planeta cargarXML:@"datospaises.xml"];
    VCAppDelegate * delegado = [UIApplication sharedApplication].delegate;
    delegado.viewController = self;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Carga el TableView con los datos de los países que se han cargado al inicializar el planeta
 */
-(void) planetaCargado:(VCPlaneta *) planeta{
    NSLog(@"Planeta cargado");
    self->elPlaneta=planeta;
    UITableView * tabla=(UITableView *)self.view;
    [tabla reloadData];
    
}

/*
 * Método para calcular las filas de la única sección de la tabla
 */
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self->elPlaneta.paises.count;
}

/*
 * Método para colocar los nombres de los países del planeta en las celdas de la tabla
 */
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * celda=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    VCPais * pais=[self->elPlaneta.paises objectAtIndex:indexPath.row];
    celda.textLabel.text=pais.nombre;
    return celda;
}

/*
 * Método para indicar el título de la tabla
 */
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    return @"Elige el país";
}

/*
 * Método para acceder al view controller de los mapas
 */
- (void)tableView:(UITableView *)tableView didHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    //Instancia el ViewController de la pantalla de los mapas
    VCMapaViewController * controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"ViewMapa"];
    
    //Selecciona la imagen del país elegido para colocarla en la vista
    VCPais * pais = [self->elPlaneta.paises objectAtIndex:indexPath.row];
    controlador.imagenPais=[[UIImageView alloc] init];
    [controlador.view addSubview:controlador.imagenPais];
    controlador.imagenPais.image=pais.imagen;
    
    //Inicia el juego con su país y el jugador (ambos se guardan en el ranking)
    controlador.juego=[[VCJuego alloc] init];
    controlador.juego.pais=pais;
    controlador.juego.jugador=[[VCJugador alloc] init];
    
    //Inicia el controlador de MapaViewController
    [controlador inicializar];
    [self.navigationController pushViewController:controlador animated:YES];
    
}

@end
