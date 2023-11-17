public enum Note {
	DO("C"),
	RE("D"),
	MI("E"),
	FA("F"),
	SOL("G"),
	LA("A"),
	SI("B");
	
	private String USCipherLetter;

	private Note(String uSCipherLetter) {
		USCipherLetter = uSCipherLetter;
	}
	
	public String getUSCipherLetter(){
		return USCipherLetter;
	}
	
}
