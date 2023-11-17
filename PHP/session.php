<?php
   session_start();

   if(!empty($_SESSION['user'])){
      $user_check = $_SESSION['user'];
   
     // $ses_sql = mysqli_query("script","SELECT * from usuarios where nombreusuario = '$user_check' ");
   
      //$row = mysqli_fetch_array($ses_sql,MYSQLI_ASSOC);
   
     // $login_session = $row['username'];
   }
   
   

   if (isset($_GET['logout'])) {
      session_destroy();
      unset($_SESSION['nombreusuario']);
      header("location: login.php");
   }
   
?>