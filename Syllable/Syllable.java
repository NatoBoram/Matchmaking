package pkSyllabe;
import javax.swing.*;
import java.util.*;

public class Syllabe {

	// Variables
	final static char[] VOYELLES = {'a', 'e', 'i', 'o', 'u', 'y'};
	final static char[] CONSONNES = {'b', 'c', 'd', 'f', 'g', 'h',
			'j', 'k', 'l', 'm', 'n', 'p', 'q', 'r', 's', 't', 'v', 'w', 'x', 'z'};

	public static void main(String[] args) {
		// Variables
		Random r = new Random();
		String mot = "";

		// Message
		int c = Integer.parseInt(JOptionPane.showInputDialog(null, "Combien de syllabes?", "Syllabe 0.1", JOptionPane.PLAIN_MESSAGE));

		// Générer les syllabes
		for(; c > 0; c--) {

			// Première consonne
			int x = r.nextInt(2);
			if (x == 0) {
				mot += CONSONNES[r.nextInt(CONSONNES.length)];

				// Deuxième consonne
				x = r.nextInt(2);
				if (x == 0) mot += CONSONNES[r.nextInt(CONSONNES.length)];
			}

			// Première voyelle
			x = 0;
			if (x == 0) {
				mot += VOYELLES[r.nextInt(VOYELLES.length)];

				// Deuxième voyelle
				x = r.nextInt(2);
				if (x == 0) {
					mot += VOYELLES[r.nextInt(VOYELLES.length)];

					// Troisième voyelle
					x = r.nextInt(2);
					if (x == 0) {
						mot += VOYELLES[r.nextInt(VOYELLES.length)];
					}
				}
			}

			// Première consonne
			x = r.nextInt(2);
			if (x == 0) {
				mot += CONSONNES[r.nextInt(CONSONNES.length)];

				// Deuxième consonne
				x = r.nextInt(2);
				if (x == 0) mot += CONSONNES[r.nextInt(CONSONNES.length)];
			}
		}
		JOptionPane.showMessageDialog(null, "Le mot généré est : " + mot, "Syllabe 0.1", JOptionPane.PLAIN_MESSAGE);
	}
}
