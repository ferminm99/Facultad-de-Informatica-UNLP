<!--Trabajo Practico-->
<!doctype html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" type="text/css" href="DiseñoRegistro.css">
  </head>

  <body>
    <form action="registration.php" method="post" onsubmit="return formValidation()">
      <div class="container">
        <h1>Registrarse</h1>
        <p>Creación de cuenta</p>
        <hr>

        <label for="name"><b>Nombre: </b></label>
        <input type="text" placeholder="Ingrese su nombre" name="name" id="name" required>

        <label for="surname"><b>Apellido: </b></label>
        <input type="text" placeholder="Ingrese su apellido" name="surname" id="surname" required>

        <label for="user"><b>Nombre de Usuario</b></label>
        <input type="text" placeholder="Ingrese el nombre de usuario" name="user" id="user" required>

        <label for="psw"><b>Contraseña</b></label>
        <input type="password" placeholder="Ingrese la contraseña" name="psw" id="psw" required>

        <label for="psw-repeat"><b>Repita la Contraseña</b></label>
        <input type="password" placeholder="Repita la Contraseña" name="psw-repeat" id="psw-repeat" required>
        <hr>

        <button type="submit" class="registerbtn" name="reg_user" >Registrarse</button>
      </div>

      <div class="container signin">
        <p>¿Ya tiene una cuenta? <a href="login.php">Iniciar sesión</a>.</p>
      </div>
    </form>

  </body>

  <script src="validation.js">
  </script>
  
</html>
