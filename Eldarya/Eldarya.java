package pkEldarya;
import java.io.*;
import javax.swing.*;
import pkUpdater.*;
public class Eldarya {
	final static String PROJECTNAME = "Eldarya";
	final static String VERSION = "1.0.0";
	public static void main(String[] args) throws IOException {
		Updater.update(PROJECTNAME, VERSION);
		final String[] OPTIONS = {"+5%", "-5%", "/5-5%"};
		double maana = Double.parseDouble(JOptionPane.showInputDialog(null, "Maana", "Eldarya", JOptionPane.PLAIN_MESSAGE));
		int option = JOptionPane.showOptionDialog(null, "Options", "Eldarya", JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, OPTIONS, OPTIONS);
		if (option == -1) System.exit(0);
		else if (OPTIONS[option].equals("+5%")) JOptionPane.showMessageDialog(null, Math.round(maana/100*105), "Eldarya", JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("-5%")) JOptionPane.showMessageDialog(null, Math.round(maana/105*100), "Eldarya", JOptionPane.PLAIN_MESSAGE);
		else if (OPTIONS[option].equals("/5-5%")) JOptionPane.showMessageDialog(null, Math.round(maana/5/105*100), "Eldarya", JOptionPane.PLAIN_MESSAGE);
	}
}