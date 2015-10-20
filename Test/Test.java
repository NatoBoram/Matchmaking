package pkTest;

import pkUpdate.*;
import java.io.*;

import javax.swing.*;

public class Test {
	static final String PROJECTNAME = "Test";
	static final String VERSION = "1.2.1";

	public static void main(String[] args) throws IOException {

		JFrame menu = new JFrame("Menu");

		menu.setUndecorated(true);
		menu.setVisible(true);
		menu.setLocationRelativeTo(null);

		// Menu
		JOptionPane.showMessageDialog(menu, "Updater version " + VERSION, PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE);
		
		// Test
		JOptionPane.showMessageDialog(null, System.getProperty("user.dir"), "Path", JOptionPane.PLAIN_MESSAGE);

		Updater.update(PROJECTNAME, VERSION);
		menu.dispose();
	}
}