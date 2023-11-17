
public class SingletonCharlyTest {

	public static void main(String[] args) {
		Note[] notes = {Note.DO, Note.FA, Note.LA, Note.MI, Note.RE, Note.SI, Note.SOL};
		int[] durations = {1, 2, 3, 4, 5, 6, 7};
		SingletonCharly.INSTANCE.playSong(notes, durations);
	}
}
