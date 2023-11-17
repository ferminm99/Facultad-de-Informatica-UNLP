<html lang="en">
	<head>
		<meta charset="UTF-8">
		<title>Listado de películas</title>
		<link rel="stylesheet" type="text/css" href="estilosZoom.css">
	</head>
	<body>
		<header>		
			<img src="Peliculas/peliculas2.jpg" alt=Peliculas Perpetua>	
			<div class="registro">	
			<a href="Registro.php">Registrarse</a>
			<a href="login.php">Inicio de sesion</a>	
			</div>
			<form method="get" action="index.php">
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
				<!---->
			</form>
		</header>

		<?php
			include_once 'conexion.php';

			$conn = OpenCon();

			include_once 'peliYComentarios.php';

			$conn->close();	

		?>


		<script src="verificarComentario.js" >

		</script>
							
		<form onsubmit="return verificarComentar()" method="post">
			<textarea name="comment" class="comment" id="commentId"></textarea><br />
			<input type="submit" value="Comentar" name="verificarC" class="verifC"/>  
			<select id ="nota" name="puntuacion">
				<option value="0">Puntuación</option>
				<option value="1">1</option>
				<option value="2">2</option>
				<option value="3">3</option>
				<option value="4">4</option>
				<option value="5">5</option>
				<option value="6">6</option>
				<option value="7">7</option>
				<option value="8">8</option>
				<option value="9">9</option>
				<option value="10">10</option>
			</select>
		</form>						
	</body>

	
	<?php
		include_once "verificacionC.php";
	?>
	

</html>



