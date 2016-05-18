package pkSyllable;
import java.io.IOException;
import java.util.Random;

import javax.swing.JFrame;
import javax.swing.JOptionPane;
import pkUpdater.Updater;

/* Changelog
 * 0.0.1 : Syllable created.
 * 0.0.2 : Optimized code.
 * 0.0.3 : More Letters, Fewer Letters, Latin Japanese and Japanese generator.
 * 1.0.0 : Auto Updater
 * 1.0.1 : Infinite Loop
 * 1.0.2 : Minimum 3 letters
 * 1.0.3 : Cherokee
 * 1.0.4 : JFrame
 * TODO : No more global
 */

public class Syllable {

	// Variables
	final static String PROJECTNAME = "Syllable";
	final static String VERSION = "1.0.4";
	static JFrame menu = new JFrame(PROJECTNAME);
	static Random r = new Random();
	
	// Create a syllable
	private static String syllabe(String type) {
		// Variables
		final char[] VOWELS = {'a', 'e', 'i', 'o', 'u', 'y'};
		final char[] CONSONANTS = {'b', 'c', 'd', 'f', 'g', 'h',
				'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z'};
		final String[] JAPANESE = {
				"a", "ka", "sa", "ta", "na", "ha", "ma", "ya", "ra", "wa",
				"i", "ki", "shi", "chi", "ni", "hi", "mi", "ri", "wi",
				"u", "ku", "su", "tsu", "nu", "fu", "mu", "yu", "ru",
				"e", "ke", "se", "te", "ne", "he", "me", "re", "we",
				"o", "ko", "so", "to", "no", "ho", "mo", "yo", "ro", "wo"};
		final String[] CHEROKEE = {
				"a", "ga", "ka", "ha", "la", "ma", "na", "hna", "nah", "qua", "s", "sa", "da", "ta", "dla", "tla", "tsa", "wa", "ya",
				"e", "ge", "he", "le", "me", "ne", "que", "se", "de", "te", "tle", "tse", "we", "ye",
				"i", "gi", "hi", "li", "mi", "ni", "qui", "si", "di", "ti", "tli", "tsi", "wi", "yi",
				"o", "go", "ho", "lo", "mo", "no", "quo", "so", "do", "tlo", "tso", "wo", "yo",
				"u", "gu", "hu", "lu", "mu", "nu", "quu", "su", "du", "tlu", "tsu", "wu", "yu",
				"\u01DD\u0303", "g\u01DD\u0303", "h\u01DD\u0303", "l\u01DD\u0303", "m\u01DD\u0303", "n\u01DD\u0303", "qu\u01DD\u0303", "s\u01DD\u0303", "d\u01DD\u0303", "tl\u01DD\u0303", "ts\u01DD\u0303", "w\u01DD\u0303", "y\u01DD\u0303"
		};

		String s = "";

		// Totally Random
		if (type.equals("More Letters")) {

			// Step 1
			if (r.nextInt(2) == 0) { 
				s += CONSONANTS[r.nextInt(CONSONANTS.length)];
				if (r.nextInt(2) == 0) s += CONSONANTS[r.nextInt(CONSONANTS.length)];
			}

			// Step 2
			s += VOWELS[r.nextInt(VOWELS.length)];
			if (r.nextInt(2) == 0) s += VOWELS[r.nextInt(VOWELS.length)];

			// Step 3
			if (r.nextInt(2) == 0) { 
				s += CONSONANTS[r.nextInt(CONSONANTS.length)];
				if (r.nextInt(2) == 0) s += CONSONANTS[r.nextInt(CONSONANTS.length)];
			}
		}

		// Fewer letters
		else if(type.equals("Fewer Letters")) {
			if (r.nextInt(2) == 0) s += CONSONANTS[r.nextInt(CONSONANTS.length)];
			s += VOWELS[r.nextInt(VOWELS.length)];
			if (r.nextInt(2) == 0) s += VOWELS[r.nextInt(VOWELS.length)];
			if (r.nextInt(2) == 0) s += CONSONANTS[r.nextInt(CONSONANTS.length)];
		}

		// Latin Japanese
		else if(type.equals("Latin Japanese")) {
			s += VOWELS[r.nextInt(VOWELS.length)];
			s += CONSONANTS[r.nextInt(CONSONANTS.length)];
		}

		// Japanese
		else if(type.equals("Japanese")) {
			s += JAPANESE[r.nextInt(JAPANESE.length)];
		}

		// Cherokee
		else if(type.equals("Cherokee")) {
			s += CHEROKEE[r.nextInt(CHEROKEE.length)];
		}

		return s;
	}

	// Create a word
	private static String word(String type) {
		String w = syllabe(type);
		while(r.nextInt(2) == 0) w += syllabe(type);
		while(w.length() < 3) w += syllabe(type);
		return w;
	}

	// Create a sentence
	private static String sentence(String type) {
		String s = word(type);
		while(r.nextInt(2) == 0) {
			s += " ";
			s += word(type);
		}
		return s;
	}

	// Create a paragraph
	private static String paragraph(String type) {
		String p = sentence(type);
		while(r.nextInt(2) == 0) {
			p += "\n";
			p += sentence(type);
		}
		return p;
	}

	// Create a page
	private static String page(String type) {
		String p = paragraph(type);
		while(r.nextInt(2) == 0) {
			p += "\n\n";
			p += paragraph(type);
		}
		return p;
	}

	public static void main(String[] args) throws IOException {
		final String[] OPTIONS = {"More Letters", "Fewer Letters", "Latin Japanese", "Japanese", "Cherokee"};
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);

		while(true) {
			try {
				// Menu
				String MESSAGE = page((String) JOptionPane.showInputDialog(null, "Which generator do you want?", PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS[1]));
				JOptionPane.showMessageDialog(null, "The created page is :\n\n" + MESSAGE, PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE);
			} catch (Exception e) {
				menu.dispose();
				Updater.update(PROJECTNAME, VERSION);
				System.exit(0);
			}
		}
	}
}