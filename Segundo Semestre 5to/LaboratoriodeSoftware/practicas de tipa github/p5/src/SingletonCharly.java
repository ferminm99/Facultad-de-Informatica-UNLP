
public enum SingletonCharly {
	INSTANCE(new Piano());
	
	private Piano piano; 
	
	public Piano getPiano(){
		return piano;
	}

	private SingletonCharly(Piano piano) {
		this.piano = piano;
	}
	
	public void playSong(Note[] notes, int[] durations){
		for (int i = 0; i< notes.length; i++) {
			this.piano.hacerSonar(notes[i], durations[i]);
		}
	
	}
}
