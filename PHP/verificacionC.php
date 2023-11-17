<?php
	include_once 'conexion.php';
	$id= $_GET['id'];
	$conn = OpenCon();
	if(isset($_POST["verificarC"])){
		if($_POST["comment"]>0){
			if($_POST["puntuacion"]!=0){
				if (isset($_SESSION['username'])) {
					$sql  = "SELECT * FROM usuarios";
					$result = $conn->query($sql);
					if ($row = $result->fetch_assoc())
						{
												
							$sql2 = "INSERT INTO  comentarios (usuarios_id,peliculas_id,comentario,calificacion,fecha) 
									VALUES ('".$row["id"]."','".$id."','".$_POST["comment"]."','".$_POST["puntuacion"].",'".$date = date('Y-m-d H:i:s')."')";
							mysqli_query($conn, $sql2);
													
						}
				}else{
					//alert("Debes iniciar sesion para comentar");
				}
			}else{
				//alert("Debes calificar la pelicula para poder comentar");
			}
		}else{
			//alert("El comentario debe tener al menos 1 caracter");
		}
	}
	//guardar comentario
	$conn->close();	
?>
