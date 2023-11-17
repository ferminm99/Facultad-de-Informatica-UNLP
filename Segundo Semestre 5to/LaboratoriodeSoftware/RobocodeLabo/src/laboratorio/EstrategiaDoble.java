package laboratorio;
import java.util.Random;


public class EstrategiaDoble implements Estratega{

	private static final EstrategiaDoble instance = new EstrategiaDoble();
	private static final Estrategia pared = new EstrategiaDoble.EstrategiaPared();
	private static final Estrategia ramfire = new EstrategiaDoble.EstrategiaSuicida();
	private String estado = "pared";
	
	public static Estratega getInstance() {
		return instance;
	}
	
	public Estrategia strategyForRunning(MorenoRobot robot) {
		if (robot.others >= 3) {
			return EstrategiaDoble.pared;			
		} else {
			this.estado = "suicida";
			return EstrategiaDoble.ramfire;	
		}
	}
	
	public Estrategia strategyForOnScannedRobot(MorenoRobot robot) {
		if (this.estado == "pared") {
			return EstrategiaDoble.pared;
		} else {
			return EstrategiaDoble.ramfire;
		}			
	}
	
	public Estrategia strategyForOnHitByBullet(MorenoRobot robot) {
		if (robot.others >= 3) {
			this.estado = "correr";
			return EstrategiaDoble.ramfire;
		} else {
			if (robot.energy > 50) {
				this.estado = "correr";
				return EstrategiaDoble.ramfire;			
			}
			if (this.estado == "pared") {
				return EstrategiaDoble.pared;
			} else {
				return EstrategiaDoble.ramfire;
			}		
		}
	}
	
	public Estrategia strategyForOnHitWall(MorenoRobot robot) {
		if (this.estado == "pared") {
			return EstrategiaDoble.pared;
		} else {
			return EstrategiaDoble.ramfire;
		}
	}
	
	public Estrategia strategyForOnHitRobot(MorenoRobot robot) {
		if (this.estado == "pared") {
			return EstrategiaDoble.pared;
		} else {
			return EstrategiaDoble.ramfire;
		}
	}
	
		
	public static class EstrategiaSuicida implements Estrategia {
		private int angulo = -1;
		private int distancia = -1;
		private int anguloCuerpo = -1;
		
		public void run(MorenoRobot robot) {
			robot.turnGunTo(robot.heading);		
			double angle = Math.toRadians((this.angulo + this.anguloCuerpo) % 360);
			int scannedY = (int)(robot.robotX + Math.cos(angle) * this.distancia);
			if (this.angulo >= 180 && this.angulo <= 360) {
				if (robot.robotY <= scannedY) {
					robot.turnRight(360);
				} else {
					robot.turnLeft(360);									
				}
			} else {
				if (robot.robotY <= scannedY) {
					robot.turnRight(360);
				} else {
					robot.turnLeft(360);									
				}
			}			
			 
		}
		
		public void onScannedRobot(MorenoRobot robot) {
			this.angulo = robot.scannedHeading;
			this.distancia = robot.scannedDistance;
			this.anguloCuerpo = robot.scannedBearing;
			robot.turnTo(robot.scannedAngle);
			robot.fire(3);					
			robot.ahead(50);
		}
		
		public void onHitByBullet(MorenoRobot XAEA_12) {
			XAEA_12.doNothing(1);
		}
		
		public void onHitWall(MorenoRobot robot) {
			if (robot.hitWallBearing >= 170 && robot.hitWallBearing <= 185) {
				robot.ahead(100);
			} else if (robot.hitWallBearing <= -170 && robot.hitWallBearing >= -185) {
				robot.ahead(100);
			} else {
				robot.back(100);
			}
		}
		
		public void onHitRobot(MorenoRobot XAEA_12) {
			XAEA_12.doNothing(1);
		}
	}

	
	public static class EstrategiaPared implements Estrategia{
		private int recibidas = 0; 
		
		public void run(MorenoRobot robot) {
			if ((robot.robotX >= robot.fieldWidth-30 && robot.robotX <= robot.fieldWidth)  || (robot.robotX >= 0 && robot.robotX <= 30)) {
				int r;
				int high;
				int low;
				Random random = new Random();
				if (robot.heading == 270) {
					robot.turnTo(360);
					//calcula distancia random a recorrer sin chocarse la pared
					high = robot.fieldHeight-robot.robotY-30;
					low = (int) (high*0.4);
					r = random.nextInt(high-low) + low;
				} else if (robot.heading == 90) {
					robot.turnTo(360);
					high = robot.fieldHeight-robot.robotY-30;
					low = (int) (high*0.4);
					r = random.nextInt(high-low) + low;
				} else {
					if (!robot.adelante) {
						high = robot.fieldHeight-robot.robotY-30;
						low = (int) (high*0.4);
						r = random.nextInt(high-low) + low;	
					} else {
						high = robot.robotY-30;
						low = (int) (high*0.4);
						r = random.nextInt(high-low) + low;
					}
				}
				if (robot.robotX >= 0 && robot.robotX <= 30) {
					robot.turnGunTo(90);
				} else {
					robot.turnGunTo(270);
				}
				if (!robot.adelante) {
					robot.adelante = true;
					robot.ahead(r);
				} else {
					robot.adelante = false;
					robot.back(r);
				}
			} else {
				if (robot.robotX >= robot.fieldWidth/2) {
					robot.turnTo(90);
					robot.ahead(robot.fieldWidth-robot.robotX-30);
				} else {
					robot.turnTo(270);
					robot.ahead(robot.robotX-30);
				}
			}
		}
		
		public void onScannedRobot(MorenoRobot robot) {
			robot.fire(2);
		}
		
		public void onHitByBullet(MorenoRobot robot) {
			if (this.recibidas >= 2) {
				this.recibidas = 0;
				robot.ahead(1);
				robot.adelante = false;
				if (robot.robotX >= 0 && robot.robotX <= 30) {
					robot.turnTo(90);
					if (robot.robotY >= robot.fieldHeight/2) {
						robot.turnGunTo(180);
					} else {
						robot.turnGunTo(360);
					}
					robot.ahead(robot.fieldWidth-robot.robotX-30);
				} else if (robot.robotX >= robot.fieldWidth-30 && robot.robotX <= robot.fieldWidth) {
					robot.turnTo(270);
					if (robot.robotY >= robot.fieldHeight/2) {
						robot.turnGunTo(180);
					} else {
						robot.turnGunTo(360);
					}
					robot.ahead(robot.robotX-30);
				}
			} else {
				this.recibidas++;
			}
		}
		
		public void onHitRobot(MorenoRobot robot) {
			robot.doNothing();
		}
		
		public void onHitWall(MorenoRobot robot) {
			robot.back(100);
		}
	}

}
