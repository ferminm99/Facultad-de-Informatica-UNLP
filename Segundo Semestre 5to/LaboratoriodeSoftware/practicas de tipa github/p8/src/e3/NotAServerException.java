package e3;

public class NotAServerException extends Exception {
    @Override
    public String getMessage(){
        return "La clase parametrizada no representa a un server web";
    }
}
