//
//  VCFinJuegoViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 16/11/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCFinJuegoViewController.h"
#import "VCRankingLocalViewController.h"

@interface VCFinJuegoViewController ()

@end

@implementation VCFinJuegoViewController
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
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Guarda el nombre introducido por el jugador en la base de datos
 */
-(IBAction) guardarNombre:(id) sender{
    //Toma el nombre introducido en la etiqueta etiquetaNombre y lo guarda en el jugador
    NSString * nombre=self.etiquetaNombre.text;
    self.juego.jugador.nombre=nombre;
    //Inserta los datos en la base de datos local
    [self.juego persistir];
   /* //Pregunta al jugador si quiere guardar los datos en remoto
    [[[UIAlertView alloc] initWithTitle:@"ranking" message:@"Quieres entrar en el ranking mundial" delegate:nil cancelButtonTitle:@"NO" otherButtonTitles:@"SI", nil] show];
    */
    //Instancia
    VCRankingLocalViewController * controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"rankinglocal"];
    controlador.juego = self.juego;
    
    [self.navigationController pushViewController:controlador animated:YES];
}

/*
 * Método para ocultar teclado cuando se pulsa fuera de la etiqueta y del teclado
 */
-(IBAction)ocultarTeclado:(id)sender{
    [self.etiquetaNombre resignFirstResponder];
}


@end
