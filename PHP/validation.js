function formValidation()
{

var uid = document.getElementById("user");
      var passid = document.getElementById("psw");
      var uname = document.getElementById("name");
      var surname = document.getElementById("surname");
      var passid_repeat = document.getElementById("psw-repeat");

      
      if(allLetter(uname,"nombre"))
        {
          if(allLetter(surname,"apellido"))
            { 
              if(userid_validation(uid,6))
              {
                if(passid_validation(passid,6))
                  {
                  if(pass_repeat(passid_repeat,passid)){
                      return true;
                  }
                }
              }
          }
      }
      return false;

    function userid_validation(uid,mx)
    {

      //Cuando tenga la base de datos debo verificar si ya no existe un usuario con el mismo nombre!

      var letters = /^[0-9a-zA-Z]+$/;
      var uid_len = uid.value.length;

      if(uid.value.match(letters)){
        if (uid_len < mx)
        {
          alert("El usuario debe tener 6 caracteres o más");
          uid.focus();
          return false;   
        }
        return true;
      }else{
        alert("El usuario debe tener solo caracteres alfanumericos");
        uid.focus();
        return false;
      }
      
    }

    function passid_validation(passid,mx)
    {
      var passid_len = passid.value.length;
      var letters = /^((?=.*[a-z])(?=.*(\W|\d))(?=.*[A-Z]).{6,})$/;

      if (passid_len < mx)
      {
        alert("La contraseña debe tener 6 caracteres o más");
        passid.focus();
        return false;
      }else{
        if(passid.value.match(letters)){
          return true;
        }else{
          alert("La contraseña debe tener alfanumericos, al menos una mayuscula,al menos una minuscula y un caracter especial");
          passid.focus();
          return false; 
        }
      }
        
    }

    function pass_repeat(passid_repeat,passid)
    {
      if(passid_repeat.value == passid.value){
        return true;
      }else{
        passid_repeat.focus();
        alert("Las contraseñas no coinciden");
        return false;
      }
    }

    function allLetter(uname,nameOrSur)
    { 
      console.log(uname);
      var uname_len = uname.value.length;
      var letters = /^[A-Za-z]+$/;
      if((uname_len>0) && (uname.value.match(letters)))
      {      
        return true;
      }
      else
      {
        alert('El ' +nameOrSur+' solo debe tener solo caracteres y mas de 1');
        uname.focus();
        return false;
      }
    }
    


}

