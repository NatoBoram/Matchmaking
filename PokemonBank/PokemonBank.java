package pkPokemonBank;
import pkUpdate.*;
import java.io.*;
import javax.swing.*;

public class PokemonBank {

	// Variables
	final static String PROJECTNAME = "PokemonBank";
	final static String VERSION = "1.2.7";

	// Get box number
	private static int getBox(int id) {
		return (int) Math.round((id - 1) / 30 + 0.5);
	}

	// Get position in box
	static int getPos(int id) {
		for (int pos = id; true; pos -= 30) {
			if (pos <= 30) return pos;
		}
	}

	// Get X coordinate
	static int getX(int pos) {
		for (int x = pos; true; x -= 6) {
			if (x <= 6) return x;
		}
	}

	// Get Y coordinate
	static int getY(int pos) {
		for (int y = 1; true; y++) {
			if (pos <= 6) return y;
			else pos -= 6;
		}
	}

	public static void main(String[] args) throws IOException {

		// Update
		Updater.update(PROJECTNAME, VERSION);

		// JFrame
		JFrame menu = new JFrame("Pokémon Bank");
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);

		// Menu
		while (true) {

			// Shiny : \u2605
			// Pokérus : \u263A
			// Last Generation : \u2B1F
			// Health Points : \u25CF \u25CB
			// Attack : \u25B2 \u25B3
			// Defense : \u25A0 \u25A1
			// Special Attack : \u2665 \u2661
			// Special Defense : \u2605 \u2606
			// Speed : \u25C6 \u25C7

			String iv = "\n";
			if (Math.round(Math.random() * 4096) == 4096) iv += "\u2605";
			else iv += " ";
			if (Math.round(Math.random() * 21845) == 21845) iv += "\u263A";
			else iv += " ";
			if (Math.round(Math.random() * 721) >= 650) iv += "\u2B1F";
			else iv += " ";

			iv += " ";
			if (Math.round(Math.random() * 32) == 32) iv += "\u25CF";
			else iv += "\u25CB";
			if (Math.round(Math.random() * 32) == 32) iv += "\u25B2";
			else iv += "\u25B3";
			if (Math.round(Math.random() * 32) == 32) iv += "\u25A0";
			else iv += "\u25A1";
			if (Math.round(Math.random() * 32) == 32) iv += "\u2665";
			else iv += "\u2661";
			if (Math.round(Math.random() * 32) == 32) iv += "\u2605";
			else iv += "\u2606";
			if (Math.round(Math.random() * 32) == 32) iv += "\u25C6";
			else iv += "\u25C7";

			if (iv.toCharArray()[1] == '\u2605') iv += "\nHoly shit! It's a Shiny!";
			if (iv.toCharArray()[2] == '\u263A') iv += "\nHoly shit! The Pokérus!";
			if (iv.toCharArray()[5] == '\u25CF'
					&& iv.toCharArray()[6] == '\u25B2'
					&& iv.toCharArray()[7] == '\u25A0'
					&& iv.toCharArray()[8] == '\u2665'
					&& iv.toCharArray()[9] == '\u2605'
					&& iv.toCharArray()[10] == '\u25C6') iv += "\nHoly shit! A Perfect Pokémon!";
			if (iv.equals("\n    \u25CB\u25B3\u25A1\u2661\u2606\u25C7")) iv = "";
			
			String sid = JOptionPane.showInputDialog(menu, "What is the Pokémon's Pokédex Number?" + iv,
					"Pokémon Bank " + VERSION, JOptionPane.PLAIN_MESSAGE);

			try {
				if (sid == null || Integer.parseInt(sid) < 1) {
					menu.dispose();
					System.exit(0);
				}

				int id = Integer.parseInt(sid);

				if (id > 721) {
					String[] options = {"Wynaut?", "Oops!"};
					if (JOptionPane.showOptionDialog(menu, "Exploring random numbers, aren't we?",
							"Pokémon Bank", JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, options, options[0]) == 1) {
						continue;
					}
				}
				
				JOptionPane.showMessageDialog(menu, "The Pokémon #" + id + " goes to box " + getBox(id) + " (" + getX(getPos(id)) + ", " + getY(getPos(id)) + ").",
						"Pokémon Bank", JOptionPane.PLAIN_MESSAGE);
			}
			
			catch (Throwable e) {
				JOptionPane.showMessageDialog(menu, "Please enter a valid number.", "Error", JOptionPane.ERROR_MESSAGE);
			}
		}
	}
}
