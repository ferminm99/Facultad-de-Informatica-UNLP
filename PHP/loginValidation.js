 function formValidation()
    {
      var uid = document.getElementById("user");
      var passid = document.getElementById("psw");

      if(userid_validation(uid,0))
      {
        if(passid_validation(passid,0))
          {
              return true;
          }
      }
      return false;
    }

    function userid_validation(uid,mx)
    {

      var uid_len = uid.value.length;

      if(uid.value.match(letters)){
        if (uid_len <= mx)
        {
          alert("Ingrese el usuario");
          uid.focus();
          return false;   
        }
        return true;
      }
    }

    function passid_validation(passid,mx)
    {
      var passid_len = passid.value.length;

      if (passid_len <= mx)
      {
        alert("Ingrese la contraseña");
        passid.focus();
        return false;
      }
        
    }