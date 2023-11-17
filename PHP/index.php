<!--Trabajo Practico-->
<!doctype html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Listado de películas</title>
		<link rel="stylesheet" type="text/css" href="estilostp.css">
	</head>
	<body>
		<header>		
			<img src="Peliculas/peliculas2.jpg" alt=Peliculas Perpetua height="300" width="100%">	
			<div class="registro">	
			<a href="Registro.php">Registrarse</a>
			<a href="login.php">Inicio de sesion</a>	
			</div>
			<form method="get" >
				<input type="text" name="searchName" placeholder="Buscar">
				<div class="selects">
				<input type="number" name="searchYear" placeholder="año "min="1900">
				<select name="searchGenre">
					<option value="genero" selected>Genero</option>
					<option value="Drama" >Drama</option>
					<option value="Comedia">Comedia</option>
					<option value="Acción">Acción</option>
					<option value="Gangsters">Gangsters</option>
					<option value="Comedia negra">Comedia negra</option>
					<option value="Fantasía">Fantasía</option>
					<option value="Aventuras">Aventuras</option>
					<option value="Ciencia ficción">Ciencia ficción</option>
					<option value="Thriller">Thriller</option>
				</select>
				<input type="submit" value="Buscar" name="buscador">
				</div>
				<div class="buttons">
					<button type="submit" name="orderByName" >Ordenar por nombre</button>
					<button type="submit" name="orderByYear" >Ordenar por año</button>
				</div>
				<!---->
			</form>
		</header>
		<?php
					
			include_once 'conexion.php';

			$conn = OpenCon();

			include_once 'session.php';

			$sql = "SELECT * FROM peliculas";

			if(isset($_GET['orderByName'])){
				$sql = "SELECT * FROM peliculas ORDER BY nombre ASC";
			}
			if(isset($_GET['orderByYear'])){
				$sql = "SELECT * FROM peliculas ORDER BY anio ASC";
			}
					
			include_once 'searchMethod.php';

			include_once 'showOrdered.php';

			$conn->close();
					
		?>
		<footer>
			<a href="#">ant  </a>	
			<a href="#">sig  </a>	
			<a href="#"> 1 </a>	
			<a href="#"> 2 </a>
			<a href="#"> 3 </a>	
			<a href="#">  >>  </a>		
		</footer>

	</body>
</html>