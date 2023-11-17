<?php 

	if(isset($_GET["buscador"])){

		if($_GET["searchName"]!="" && $_GET["searchGenre"]=="genero" && $_GET["searchYear"]==""){

			$sql = "SELECT * FROM peliculas WHERE nombre LIKE '%".$_GET["searchName"]."%'";

		}else if($_GET["searchName"]!="" && $_GET["searchGenre"]!="genero" && $_GET["searchYear"]==""){

			$sql = "SELECT * FROM peliculas WHERE nombre LIKE '%".$_GET["searchName"]."%' 
					AND generos_id = (SELECT id FROM generos WHERE genero LIKE '%".$_GET["searchGenre"]."%') ";	
						
		}else if($_GET["searchName"]!="" && $_GET["searchGenre"]!="genero" && $_GET["searchYear"]!=""){

			$sql = "SELECT * FROM peliculas WHERE nombre LIKE '%".$_GET["searchName"]."%' 
					AND genero LIKE '%".$_GET["searchGenre"]."%' AND anio LIKE '%".$_GET["searchYear"]."%' ";	

		}else if($_GET["searchName"]=="" && $_GET["searchGenre"]!="genero" && $_GET["searchYear"]==""){

			$sql = "SELECT * FROM peliculas WHERE genero LIKE '%".$_GET["searchGenre"]."%'";	

		}
		else if($_GET["searchName"]=="" && $_GET["searchGenre"]=="genero" && $_GET["searchYear"]!=""){

			$sql = "SELECT * FROM peliculas WHERE anio LIKE '%".$_GET["searchYear"]."%'";	

		}
		else if($_GET["searchName"]!="" && $_GET["searchGenre"]=="genero" && $_GET["searchYear"]!=""){

			$sql = "SELECT * FROM peliculas WHERE anio LIKE '%".$_GET["searchYear"]."%'
					AND nombre LIKE '%".$_GET["searchName"]."%' ";	

		}else if($_GET["searchName"]!="" && $_GET["searchGenre"]=="genero" && $_GET["searchYear"]!=""){

			$sql = "SELECT * FROM peliculas WHERE genero LIKE '%".$_GET["searchGenre"]."%'
					AND nombre LIKE '%".$_GET["searchName"]."%' ";	

		}else if($_GET["searchName"]!="" && $_GET["searchGenre"]=="genero" && $_GET["searchYear"]!=""){

			$sql = "SELECT * FROM peliculas WHERE anio LIKE '%".$_GET["searchYear"]."%'
					AND genero LIKE '%".$_GET["searchGenre"]."%' ";	

		}
			
	}

						
	

?>