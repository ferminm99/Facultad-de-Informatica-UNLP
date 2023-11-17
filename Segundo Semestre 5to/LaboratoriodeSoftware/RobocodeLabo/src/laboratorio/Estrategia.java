package laboratorio;

public interface Estrategia {
	
	public void run(MorenoRobot XAEA_12);
	public void onScannedRobot(MorenoRobot XAEA_12);
	public void onHitByBullet(MorenoRobot XAEA_12);
	public void onHitWall(MorenoRobot XAEA_12);
	public void onHitRobot(MorenoRobot XAEA_12);
	
}
