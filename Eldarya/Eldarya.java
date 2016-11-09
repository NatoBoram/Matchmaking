package pkEldarya;
import java.io.IOException;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
// import pkUpdater.Updater;

/* Changelog
 * 1.0.0 : Updater
 * 1.0.1 : JFrame
 * 1.0.2 : While(True)
 * 1.0.3 : Continue
 * 1.0.4 : Taskbar
 * 1.0.5 : $€
 * 1.0.6 : Gold
 */

public class Eldarya {
	final static String PROJECTNAME = "Eldarya";
	final static String VERSION = "1.0.4";
	static JFrame menu = new JFrame(PROJECTNAME);

	private static void exit() {
		menu.dispose();
		// Updater.update(PROJECTNAME, VERSION);
		System.exit(0);
	}

	// Units : Maanas
	private static void maana() {
		final String[] OPTIONS = { "+5%", "-5%", "/5-5%", "$€", "Pièces d'Or" };
		double maana = 0;
		while(true) {
			try {
				maana = Double.parseDouble(JOptionPane.showInputDialog(menu, "Maana", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE));
			} catch (NumberFormatException e) {
				continue;
			} catch (NullPointerException e) {
				break;
			}
			int option = JOptionPane.showOptionDialog(menu, "Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
			if (option == -1) break;
			else if (OPTIONS[option].equals("+5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 100 * 105) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
			else if (OPTIONS[option].equals("-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 105 * 100) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
			else if (OPTIONS[option].equals("/5-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 5 / 105 * 100) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
			else if (OPTIONS[option].equals("$€")) JOptionPane.showMessageDialog(menu, Math.round(maana / 500 * 5) + "$\n"
					+ Math.round(maana / 675 * 4.5) + "€", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
			else if (OPTIONS[option].equals("Pièces d'Or")) JOptionPane.showMessageDialog(menu, Math.round(maana / 500 * 165) + " Pièces d'Or Canadiennes\n"
					+ Math.round(maana / 675 * 225) + " Pièces d'Or Européennes", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		}
	}

	// Units : Pièces d'Or
	private static void gold() {
		final String[] OPTIONS = { "$€", "Maana",};
		double gold = 0;
		while(true) {
			try {
				gold = Double.parseDouble(JOptionPane.showInputDialog(menu, "Pièces d'Or", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE));
			} catch (NumberFormatException e) {
				continue;
			} catch (NullPointerException e) {
				break;
			}
			int option = JOptionPane.showOptionDialog(menu, "Pièces d'Or", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
			if (option == -1) break;
			else if (OPTIONS[option].equals("$€")) JOptionPane.showMessageDialog(menu, Math.round(gold / 165 * 5) + "$\n"
					+ Math.round(gold / 225 * 4.5) + "€", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
			else if (OPTIONS[option].equals("Maana")) JOptionPane.showMessageDialog(menu, Math.round(gold / 165 * 500) + " Maanas Canadiens\n"
					+ Math.round(gold / 225 * 675) + " Maanas Européens", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		}
	}
	
	// Menu
	public static void main(String[] args) throws IOException {
		final String[] UNITS = { "Maanas", "Pièces d'Or", "Dollars Canadiens", "Euros" };
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);
		while (true) {
			int option = JOptionPane.showOptionDialog(menu, "Unité", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, UNITS, UNITS);
			if (option == -1) exit();
			else if (UNITS[option].equals("Maanas")) maana();
			else if (UNITS[option].equals("Pièces d'Or")) gold();
		}
	}
}
