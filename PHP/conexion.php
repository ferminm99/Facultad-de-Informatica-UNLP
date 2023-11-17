<?php

	function openCon(){

		$username = "root";
		$servername = "localhost";
		$password = "";
		$dbname = "script";

		$conexion = mysqli_connect($servername, $username, $password, $dbname);

	 	// Create connection
		$conn = new mysqli($servername, $username, $password, $dbname);
		
		return $conn;
 	}
 
	function CloseCon($conn)
 	{	
	 	$conn -> close();
 	}


?>