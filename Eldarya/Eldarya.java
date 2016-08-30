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
 */

public class Eldarya {

	final static String PROJECTNAME = "Eldarya";
	final static String VERSION = "1.0.4";
	static JFrame menu = new JFrame(PROJECTNAME);
	final static String[] UNITS = { "Maanas", "Pièces d'Or", "Dollars Canadiens", "Euros" };
	final static String[] OPTIONS = { "+5%", "-5%", "/5-5%", "$€" };
	static double maana = 0;

	private static void exit() {
		menu.dispose();
		// Updater.update(PROJECTNAME, VERSION);
		System.exit(0);
	}
	
	private static void maana() {
		int option = JOptionPane.showOptionDialog(menu, "Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
		if (option == -1) exit();
		else if (OPTIONS[option].equals("+5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 100 * 105) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 105 * 100) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("/5-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana / 5 / 105 * 100) + " Maanas", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("$€")) JOptionPane.showMessageDialog(menu, Math.round(maana / 500 * 5) + "$, " + Math.round(maana / 675 * 4.5) + "€", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
	}

	public static void main(String[] args) throws IOException {
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);
		while (true) {
			try {
				maana = Double.parseDouble(JOptionPane.showInputDialog(menu, "Maana", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE));
			} catch (NumberFormatException e) {
				continue;
			} catch (NullPointerException e) {
				exit();
			}
			int option = JOptionPane.showOptionDialog(menu, "Unité", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
			if (option == -1) exit();
			else if (UNITS[option].equals("Maanas")) maana();
		}
	}
}
