<?php
	include_once 'conexion.php';
  	$db = OpenCon();
  	//$errors = array(); 

 	if (isset($_POST['login_user'])) {
    
	    $username = mysqli_real_escape_string($db, $_POST['username']);
	    $password = mysqli_real_escape_string($db, $_POST['psw']);
	    $value = "";

	    if (empty($username)) {
	    	$value+="Ingrese el nombre de usuario";
	    	setcookie("Errores",$value);
	    	//array_push($errors, "Ingrese el usuario");
	    }
	    if (empty($password)) {
	    	$value+="Ingrese la contraseña";
	    	setcookie("Errores",$value);
	    	//array_push($errors, "Ingrese la contraseña");
	    }

	    if ($_COOKIE["Errores"]=="") {
	    	$password = md5($password);
	    	$query = "SELECT * FROM usuarios WHERE nombreusuario='$username' AND password='$password'";
	    	$results = mysqli_query($db, $query);
	    	if (mysqli_num_rows($results) == 1) {
	    	  $_SESSION['username'] = $username;
	    	  $_SESSION['success'] = "Se ingreso con exito";
	    	  header('location: index.php');
	    	}else {
	    		setcookie("UoCMal","Usuario o contraseña incorrecta");
	    		 echo $_COOKIE["UoCMal"];
	    	}
	    }else{
	        echo $_COOKIE["Errores"];
     	}
  	}

?>