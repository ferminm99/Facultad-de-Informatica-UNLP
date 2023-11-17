			<?php
			

			$id= $_GET['id'];
			$sql  = "SELECT * FROM peliculas WHERE id='$id'";
			$result = $conn->query($sql);
			if ($row = $result->fetch_assoc())
			{	
			?>
				<h1>
					<?php echo $row["nombre"] ?>
					</h1>
						<section>
							<img src=<?php echo $row["contenidoimagen"] ?> alt= <?php echo $row["nombre"] ?>>
							<div class="mod">
								<h3> <?php echo $row["nombre"] ?></h3>
									<h4>Sinopsis:</h4>
									<p> <?php echo $row["sinopsis"] ?>
									</p>
									<h5>Genero: 
										<?php 
											$sql3 = "SELECT * FROM generos WHERE id='".$row["generos_id"]."' ";
											$result3 = $conn->query($sql3);
											if($row3 = $result3->fetch_assoc()){
												echo $row3["genero"];
											}
										?>
									</h5>
							</div>
						</section>
					<h3>Comentarios</h3>
			<?php	

			}


			$sql1 = "SELECT * FROM comentarios WHERE peliculas_id='$id'";
			$result1 = $conn->query($sql1);
			
				if ($result1->num_rows > 0){
				while($row = $result1->fetch_assoc()) {
					?>
					<ul>
						<li>
							<h4>
								<?php
								$sql2 = "SELECT * FROM usuarios WHERE id='".$row["usuarios_id"]."' ";
								$result2 = $conn->query($sql2);
								if($row2 = $result2->fetch_assoc()){
									echo $row2["nombreusuario"];
								
								?>
							</h4>	
							<h5>
								NOTA: 
								<?php
									echo $row2["calificacion"];
								}	
								?>/10					
							</h5>
						<p>
							<?php echo $row["comentario"] ?>
						</p>

					</ul>

			<?php	
					
				}
			}	

			
			?>