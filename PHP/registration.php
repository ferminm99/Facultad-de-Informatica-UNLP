<?php

    include_once 'conexion.php';
    $db = OpenCon();
   // $errors = array(); 

    if (isset($_POST['reg_user'])) {
      // receive all input values from the form
      $username = mysqli_real_escape_string($db, $_POST['user']);
      $name = mysqli_real_escape_string($db, $_POST['name']);
      $surname = mysqli_real_escape_string($db, $_POST['surname']); 
      $password_1 = mysqli_real_escape_string($db, $_POST['psw']);
      $password_2 = mysqli_real_escape_string($db, $_POST['psw-repeat']);
      $value = "";
      //PREGUNTAR SI ES NECESARIO HACER LAS VERIFICACIONES CON PHP TAMBIEN

      // form validation: ensure that the form is correctly filled ...
      // by adding (array_push()) corresponding error unto $errors array
    
      if (preg_match('/[^a-zA-Z]/', $name)) 
      {
        $value = "El nombre debe contener caracteres ";
      }else{
        if(strlen($name)<6){
          $value += "El nombre debe contener al menos 6 caracteres ";
        }else{
          if (preg_match('/[^a-zA-Z]/', $surname)) 
          {
            $value +="El apellido debe contener caracteres ";
           
          }else{
            if(strlen($surname)<6){
              $value +="El apellido debe tener al menos 6 caracteres ";
            }else{
              if (preg_match('/[^A-Za-z0-9]/', $username)) // '/[^a-z\d]/i' should also work.  
              {
                $value +="El usuario debe contener caracteres y numeros";
              
              }else{
                if(strlen($username)<6){
                  $value +="El usuario debe contener al menos 6 caracteres ";
                }else{

                  if (preg_match('/^(?=.*[A-Z])(?=.*[a-z])$/', $password_1))// '/[^a-z\d]/i' should also work.  
                  {
                    $value +="La contraseña debe contener caracteres ";
                  }else{
                    if((preg_match('/^(?=.*[0-9])$/', $password_1)) || (preg_match('/[^a-zA-Z\d]/', $password_1))){
                      $value +="La contraseña debe tener al menos 1 caracter especial o 1 numero ";
                    }else{
                      if(strlen($password_1)<6){
                        $value +="La contraseña debe tener al menos 6 caracteres ";
                      }else{
                        if ($password_1 != $password_2) {
                          $value +="Las 2 contraseñas no coinciden ";
                        }else{
                          $user_check_query = "SELECT * FROM usuarios WHERE nombreusuario='$username' LIMIT 1";
                          $result = mysqli_query($db, $user_check_query);
                          $user = mysqli_fetch_assoc($result);
                          
                          if ($user) { // Si el usuario existe

                            if ($user['nombreusuario'] === $username) {
                              $value +="El usuario ya existe ";
                            }

                          }
                        }

                      }
                    }
                    
                  }
                }
              }
            }
          }
        }
      } 

      // Verificar si existe el usuario en la base de datos
      // a user does not already exist with the same username and/or email
     
      // Si no hubo errores guardar el usuario nuevo.
      if ($value=="") {

        $password = md5($password_1);//encrypt the password before saving in the database

        $query = "INSERT INTO usuarios (nombreusuario, nombre, apellido, contraseña) 
              VALUES('$username', '$name', '$surname', '$password')";
        mysqli_query($db, $query);
        $_SESSION['user'] = $user;
        header('location: index.php');

     }else{
        echo '<script type="text/javascript">alert("' . $value . '")</script>';
     }

  }
    

  ?>