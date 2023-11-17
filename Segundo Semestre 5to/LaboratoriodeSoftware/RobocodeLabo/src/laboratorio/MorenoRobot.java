package laboratorio;

import robocode.*;

public class MorenoRobot extends JuniorRobot {
	protected boolean adelante = false;
	private Estratega estratega = EstrategiaDoble.getInstance();
	
	@Override	
	public void run() {
		setColors(blue, blue, yellow, yellow, yellow);
		this.estratega.strategyForRunning(this).run(this);
	}

	@Override
	public void onScannedRobot() {
		this.estratega.strategyForOnScannedRobot(this).onScannedRobot(this);
	}

	@Override
	public void onHitByBullet() {
		this.estratega.strategyForOnHitByBullet(this).onHitByBullet(this);
	}
	
	@Override
	public void onHitWall() {
		this.estratega.strategyForOnHitWall(this).onHitWall(this);
	}	
	
	@Override
	public void onHitRobot() {
		this.estratega.strategyForOnHitRobot(this).onHitRobot(this);
	}
}