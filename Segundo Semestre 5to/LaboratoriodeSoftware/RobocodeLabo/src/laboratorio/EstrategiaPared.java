package laboratorio;

import java.util.Random;

public class EstrategiaPared implements Estrategia{
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
