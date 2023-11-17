package e1.a;

public class MyColors implements ColorsImpression, RainbowColors {
    private int unColor;
    public MyColors() {
        unColor= RainbowColors.AMARILLO;
    }

    public int getUnColor() {
        return unColor;
    }
}
