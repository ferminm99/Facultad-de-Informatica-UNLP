function verificarComentar(){

	var comment = document.getElementById("commentId");
	var nota = document.getElementById("nota");

	if(comment.value.length<0){
		alert("El comentario debe tener al menos 1 caracter");
		return false;
	}
	else{
		if(nota.value != 0){
			return true;
		}else{
			alert("Para poder comentar debes calificar a la película");
			return false;
		}
	}

}