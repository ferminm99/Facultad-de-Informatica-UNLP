package laboratorio;

public interface Estratega {
	
	public Estrategia strategyForRunning(MorenoRobot robot);
	public Estrategia strategyForOnScannedRobot(MorenoRobot robot);
	public Estrategia strategyForOnHitByBullet(MorenoRobot robot);
	public Estrategia strategyForOnHitWall(MorenoRobot robot);
	public Estrategia strategyForOnHitRobot(MorenoRobot robot);
	

}
