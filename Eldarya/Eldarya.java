package pkEldarya;
import java.io.*;
import javax.swing.*;
import pkUpdater.*;

/* Changelog
 * 1.0.0 : Updater
 * 1.0.1 : JFrame
 */

public class Eldarya {
	final static String PROJECTNAME = "Eldarya";
	final static String VERSION = "1.0.1";
	public static void main(String[] args) throws IOException {
		// JFrame
		JFrame menu = new JFrame("Menu");
		menu.setUndecorated(true);
		menu.setVisible(true);
		menu.setLocationRelativeTo(null);
		
		// Eldarya
		Updater.update(PROJECTNAME, VERSION);
		final String[] OPTIONS = {"+5%", "-5%", "/5-5%"};
		double maana = 0;
		try {
			maana = Double.parseDouble(JOptionPane.showInputDialog(menu, "Maana", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE));
		} catch (Throwable e) {
			menu.dispose();
			System.exit(0);
		}
		int option = JOptionPane.showOptionDialog(menu, "Options", "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
		if (option == -1) System.exit(0);
		else if (OPTIONS[option].equals("+5%")) JOptionPane.showMessageDialog(menu, Math.round(maana/100*105), "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana/105*100), "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("/5-5%")) JOptionPane.showMessageDialog(menu, Math.round(maana/5/105*100), "Eldarya " + VERSION, JOptionPane.PLAIN_MESSAGE);
		
		menu.dispose();
		System.exit(0);
	}
}