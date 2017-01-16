<?php 
    define("ERROR_OK",0);
    define("ERROR_SERVIDOR",1);
    define("ERROR_USUARIO",2);

    
    function error($codigo){
        echo "<error><codigo valor=\"$codigo\"/></error>";
    }
    
    
    if(isset($_GET["accion"]) AND in_array($_GET["accion"],array("listar","insertar"))):
	@ $conexion=MySQL_connect("127.0.0.1:8889","root","root");
	MySQL_select_db("geoapp");
	if(!$conexion):
		error(ERROR_SERVIDOR);
	else:
        MySQL_QUERY("SET names 'UTF8'");
		if($_GET["accion"]=="listar"){
			if(isset($_GET["pais"])){
				$consulta="SELECT * FROM paises WHERE nombre='{$_GET['pais']}';";
				$resultado=MySQL_QUERY($consulta);
				if(MySQL_num_rows($resultado)){
					$consulta="SELECT * FROM ranking WHERE pais='{$_GET['pais']}' ORDER BY tiempo LIMIT 10;";
					$resultado=MySQL_QUERY($consulta);
					echo"<rankings>";
					while($registro=MySQL_FETCH_ASSOC($resultado)):
						echo "<ranking usuario=\"{$registro['usuario']}\" tiempo=\"{$registro['tiempo']}\"/>";
					endwhile;
					echo "</rankings>";
				}else{
					error(ERROR_USUARIO);
				}
			}else{
				error(ERROR_USUARIO);
			}
		}else{
            if(!isset($_GET["pais"]) || !isset($_GET["nombre"]) || !isset($_GET["tiempo"])):
                error(ERROR_USUARIO);
            else:
                $consulta="INSERT INTO ranking (pais,usuario,tiempo) VALUES('{$_GET['pais']}','{$_GET['nombre']}','{$_GET['tiempo']}');";
            $resultado=MySQL_QUERY($consulta);
            error(ERROR_OK);
            
            endif;
        }
	endif; // if conexion
    else:
    error(ERROR_USUARIO);
    endif; // if principal
    


?>