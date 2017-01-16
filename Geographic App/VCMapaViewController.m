//
//  VCMapaViewController.m
//  Geographic App
//
//  Created by Verónica Cordobés on 26/10/13.
//  Copyright (c) 2013 Verónica Cordobés. All rights reserved.
//

#import "VCMapaViewController.h"

@interface VCMapaViewController ()

@end

@implementation VCMapaViewController
@synthesize imagenPais=imagenPais,juego=juego;

/*
 * Inicializamos el ViewController de los mapas
 */
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    etiquetaPais.text=@"";
    
}

/*
 * Inicia el juego y carga las regiones
 *
 */
-(void) inicializar{
    //Indica al juego que debe empezar (para que inicie el contador del tiempo)
    [self.juego empezar];
    
    //Carga las regiones colocándolas en la ubicación inicial
    for (VCRegion * region in self.juego.pais.regiones) {
        UIImageView * vistaRegion=[[UIImageView alloc] initWithImage:region.imagen];
        CGRect ubicacion=vistaRegion.frame;
        ubicacion.origin=region.ubicacionInicial;
        vistaRegion.frame=ubicacion;
        
        //Permite la interacción del usuario y reconoce los gestos para saber cuándo la región llega a la ubicación destino
        vistaRegion.userInteractionEnabled=YES;
        [self.view addSubview:vistaRegion];
        UIPanGestureRecognizer * gesto=[[UIPanGestureRecognizer alloc]  initWithTarget:self action:@selector(handlePan:)];
        [vistaRegion addGestureRecognizer:gesto];
        gesto.delegate=self;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

/*
 * Método para volver a la pantalla anterior
 */
-(IBAction) volver{
    [self.juego terminar];
    [self.navigationController popViewControllerAnimated:YES];
}


/*
 * Controla el movimiento de las regiones
 */
- (void)handlePan:(UIPanGestureRecognizer *)recognizer {
    //Busca la región seleccionada por el usuario
    VCRegion * region=[self buscarRegion:recognizer.view];
    
    //Cuando el usuario terminade colocar la región, guardamos la ubicación que ha elegido
    if(recognizer.state==UIGestureRecognizerStateEnded){
        UIView * vista=recognizer.view;
        CGRect ubicacion=vista.frame;
        
        //si la ubicación elegida es cercana a la final, la coloca en la final
        if([self cercano:vista.frame.origin a:region.ubicacion]){
            ubicacion.origin=region.ubicacion;
            //añade un correcto al contador
            self.juego.totalCorrecto++;
            //quita el gestureRecognizer para que la región ya no se pueda mover
            [vista removeGestureRecognizer:recognizer];
            //si están todas las regiones colocadas, termina el juego
            if([self.juego todasColocadas]){
                [self.juego terminar];
                NSString * mensaje=[NSString stringWithFormat:@"Has tardado %@", [self.juego cadenaTiempo]];
                [[[UIAlertView alloc] initWithTitle:@"Fin de juego" message:mensaje delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
            }
        //si la ubicación elegida no es cercana a la final, la región vuelve a la inicial
        }else{
            ubicacion.origin=region.ubicacionInicial;
        }
        vista.frame=ubicacion;
        
        etiquetaPais.text=@"";
    //pone en la etiqueta superior el nombre de la región que selecciona el usuario
    }else{
        etiquetaPais.text = region.nombre;
        CGPoint translation = [recognizer translationInView:self.view];
    recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x,
                                         recognizer.view.center.y + translation.y);
    [recognizer setTranslation:CGPointMake(0, 0) inView:self.view];
        NSLog(@"%f, %f", recognizer.view.frame.origin.x,  recognizer.view.frame.origin.y);

    }

}

/*
 * Método para buscar la región seleccionada por el usuario
 */
-(VCRegion *) buscarRegion:(UIView *) vista{
    for (VCRegion * regionAux in self.juego.pais.regiones) {
        UIImageView * vistaRegion=(UIImageView * )vista;
        if(regionAux.imagen==vistaRegion.
           image){
            return regionAux;
        }
    }
    return nil;
}


/*
 * Permite que el gestureRecognizer comience
 */
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer{
    
    return YES;
}

/**
 * Controla que varios gestureRecognizers funcionen simultáneamente
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{

    return YES;

}

/*
 * Método para que el gestureRecognizer recoja el siguiente toque
 */
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch{

    return YES;

}

/*
 * Método que determina si la posición que elige el usuario es lo suficientemente cercana a la posición final
 * como para considerarla correcta
 */
-(BOOL) cercano:(CGPoint)R1 a:(CGPoint)R2{
    const int OFFSET = 10;
    if(R1.x>=R2.x-OFFSET && R1.x<=R2.x+OFFSET && R1.y>=R2.y-OFFSET && R1.y<=R2.y+OFFSET){
        return YES;
    }
    return NO;
}

/*
 * Método para configurar la alerta de fin de juego, muestra el tiempo tardado y lleva al siguiente view controller
 */
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    //Instancia
    VCMapaViewController * controlador = [self.storyboard instantiateViewControllerWithIdentifier:@"fin_juego"];
    controlador.juego = self.juego;

    [self.navigationController pushViewController:controlador animated:YES];
    
}



@end
