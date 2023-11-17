<?php
	$result = $conn->query($sql);
	if($result!=null){
		if ($result->num_rows > 0) {
			while($row = $result->fetch_assoc()) {
?>
						<div>
							<h4><a href=<?php echo 'zoomPeli.php?id='.$row["id"].''?>><?php echo $row["nombre"] ?></a></h4>
							<section>
									<a  href=<?php  echo 'zoomPeli.php?id='.$row["id"].''?>>
									<img src=<?php echo$row["contenidoimagen"] ?> alt=<?php echo $row["nombre"] ?>>	
									</a>
								<div>
									<ul>
										<li>Sinopsis: <?php echo $row["sinopsis"] ?></li>
										<li>Año de estreno: <?php echo $row["anio"] ?></li>
										<li>Promedio de la calificacion dada por los usuarios: 
											<?php 
												$sql10 = "SELECT * FROM comentarios"; 
												$result2 = $conn->query($sql10);
												$total = 0.0;
												$totalN = 0.0;
												if($result2!=null){
													if ($result2->num_rows > 0) {
														while($row2 = $result2->fetch_assoc()) {
															if($row2["pelicula_id"]==$row["pelicula_id"]){
																$totalN += $row2["calificacion"];
																$total++;
															}
															
														}	
														if(is_nan(@($totalN / $total))){
															echo 0;
														}else{
															echo round(($totalN / $total),2);
														}		
													}
												}else{
													echo 0;
												}
											?>
										</li>
									</ul>
								</div>
							</section>	
							<br/>
						</div>
<?php			
			}
		}else {
			echo "0 results";
		}	
	}
	
?>