package pkSyllable;
import javax.swing.*;
import pkUpdate.Updater;
import java.io.IOException;
import java.util.*;

/* Changelog
 * 0.1 : Syllable created.
 * 0.2 : Optimized code.
 * 0.3 : More Letters, Fewer Letters, Latin Japanese and Japanese generator.
 * 1.0.0 : Auto Updater
 */

public class Syllable {

	// Variables
	final static String PROJECTNAME = "Syllable";
	final static String VERSION = "1.0.0";
	static Random r = new Random();
	static String word = "";

	// Add a letter
	private static boolean add(char[] LETTERS) {
		if (r.nextInt(2) == 0) { 
			word += LETTERS[r.nextInt(LETTERS.length)];
			return true;
		}
		else return false;
	}

	// Create a syllable
	private static void syllabe(String type) {
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

		// Totally Random
		if (type.equals("More Letters")) {
			if (add(CONSONANTS)) add(CONSONANTS);
			word += VOWELS[r.nextInt(VOWELS.length)];
			if (add(VOWELS)) add(VOWELS);
			if (add(CONSONANTS)) add(CONSONANTS);
		}

		// Fewer letters
		else if(type.equals("Fewer Letters")) {
			add(CONSONANTS);
			word += VOWELS[r.nextInt(VOWELS.length)];
			add(VOWELS);
			add(CONSONANTS);
		}

		// Latin Japanese
		else if(type.equals("Latin Japanese")) {
			word += CONSONANTS[r.nextInt(CONSONANTS.length)];
			word += VOWELS[r.nextInt(VOWELS.length)];
		}

		// Japanese
		else if(type.equals("Japanese")) {
			word += JAPANESE[r.nextInt(JAPANESE.length)];
		}
	}

	// Create a word
	private static void word(String type) {
		syllabe(type);
		while(r.nextInt(2) == 0) syllabe(type);
	}

	// Create a sentence
	private static void sentence(String type) {
		word(type);
		while(r.nextInt(2) == 0) {
			word += " ";
			word(type);
		}
	}

	public static void main(String[] args) throws IOException {
		Updater.update(PROJECTNAME, VERSION);
		final String[] OPTIONS = {"More Letters", "Fewer Letters", "Latin Japanese", "Japanese"};
		sentence((String) JOptionPane.showInputDialog(null, "Which generator do you want?", PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, null));
		JOptionPane.showMessageDialog(null, "The created word is : " + word, PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE);
	}
}