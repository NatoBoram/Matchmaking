package pkSyllabe;
import javax.swing.*;
import java.util.*;

public class Syllabe {

	// Variables
	static Random r = new Random();
	static String mot = "";

	// Ajouter une lettre
	private static boolean add(char[] LETTRES) {
		if (r.nextInt(2) == 0) { 
			mot += LETTRES[r.nextInt(LETTRES.length)];
			return true;
		}
		else return false;
	}

	// Créer une syllabe
	private static void syllabe() {
		// Variables
		final char[] VOYELLES = {'a', 'e', 'i', 'o', 'u', 'y'};
		final char[] CONSONNES = {'b', 'c', 'd', 'f', 'g', 'h',
				'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z'};

		if (add(CONSONNES)) add(CONSONNES);
		mot += VOYELLES[r.nextInt(VOYELLES.length)];
		if (add(VOYELLES)) add(VOYELLES);
		if (add(CONSONNES)) add(CONSONNES);
	}

	public static void main(String[] args) {
		syllabe();
		while(r.nextInt(2) == 0) syllabe();
		JOptionPane.showMessageDialog(null, "Le mot généré est : " + mot, "Syllabe 0.2", JOptionPane.PLAIN_MESSAGE);
	}
}
