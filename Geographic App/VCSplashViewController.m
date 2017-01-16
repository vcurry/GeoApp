//
//  VCSplashViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 28/12/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCSplashViewController.h"
#import "VCViewController.h"

@interface VCSplashViewController ()

@end

@implementation VCSplashViewController

@synthesize webView=webView;




- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

/*
 * Método que al cargar la vista, muestra la animación inicial
 */
- (void)viewDidLoad
{
    [super viewDidLoad];
    //Toma el path del bundle, donde está guardado el gif y lo inserta en el webview que se ha creado
    NSString * imagePath = [[NSBundle mainBundle] pathForResource: @"geoapp" ofType: @"gif"];
    NSData * data = [NSData dataWithContentsOfFile:imagePath];
    [self.webView setUserInteractionEnabled:NO];
    [self.webView loadData:data MIMEType:@"image/gif" textEncodingName:nil baseURL:nil];
    //Pasados 3 segundos, cambia a la pantalla de selección de países de viewController
    [self performSelector:@selector(cambiarPantalla) withObject:nil afterDelay:3];
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * Método para cambiar de pantalla a la tabla de países
 */
-(void)cambiarPantalla{
    VCViewController * controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"viewcontroller"];
    
    [self.navigationController pushViewController:controlador animated:NO];
}

@end
