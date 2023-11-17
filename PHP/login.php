<html lang="en">
  <head>
    <meta charset="UTF-8">
    <title>Registro</title>
    <link rel="stylesheet" type="text/css" href="DiseñoRegistro.css">
  </head>

  <body>
    <form action="loginVerification.php" method="post" onsubmit="formValidation()">
      <div class="container">
        <h1>Registrarse</h1>
        <p>Creación de cuenta</p>
        <hr>

        <label for="user"><b>Nombre de Usuario</b></label>
        <input type="text" placeholder="Ingrese el nombre de usuario" name="user" id="user" required>

        <label for="psw"><b>Contraseña</b></label>
        <input type="password" placeholder="Ingrese la contraseña" name="psw" id="psw" required>

        <button type="submit" class="registerbtn" name="login_user" >Ingresar</button>
      </div>

      <div class="container signin">
        <p>¿No tiene cuenta? <a href="Registro.php">Registrarse</a>.</p>
      </div>
    </form>

 <script src="loginValidation.js">
  </script>