package pkNote;
import java.io.*;
import java.text.*;
import javax.swing.*;
import pkUpdater.*;

public class Note {

	final static String PROJECTNAME = "Note";
	final static String VERSION = "1.0.1";

	static DecimalFormat twoDigits = new DecimalFormat ("0.00");
	static JFrame menu = new JFrame("Menu");

	public static void main(String[] args) throws IOException {

		menu.setUndecorated(true);
		menu.setVisible(true);
		menu.setLocationRelativeTo(null);

		double x = 0, y = 0;

		while (true) /* I am evil. */ {

			try {
				x = Double.parseDouble(JOptionPane.showInputDialog(null, "Points accumulés jusqu'à maintenant",
						"Note " + VERSION, JOptionPane.PLAIN_MESSAGE));
				y = Double.parseDouble(JOptionPane.showInputDialog(null, "Points totaux évalués jusqu'à maintenant",
						"Note " + VERSION, JOptionPane.PLAIN_MESSAGE));
			} catch (Throwable e) {
				menu.dispose();
				Updater.update(PROJECTNAME, VERSION);
				System.exit(0);
			}

			x = 60 - x;
			y = 100 - y;
			double z = 100 * (x / y);

			if (z > 100) {
				JOptionPane.showMessageDialog(null, "It's too late to apologize…" + "\nVous auriez besoin de "
						+ twoDigits.format(z) + "% pour vous rattraper.", "You failed!", JOptionPane.ERROR_MESSAGE);
			} else if (z <= 0) {
				JOptionPane.showMessageDialog(null, "Vous avez déjà passé le cours!"
						+ "\nPour échouer, vous auriez besoin de " + twoDigits.format(z) + "%.", "Félicitation!",
						JOptionPane.PLAIN_MESSAGE);
			} else if (z >= 60) {
				JOptionPane.showMessageDialog(null,
						"Vous avez besoin d'une moyenne de " + twoDigits.format(z)
						+ "% dans les futures évaluations pour passer le cours.",
						"Attention!", JOptionPane.WARNING_MESSAGE);
			} else {
				JOptionPane.showMessageDialog(null,
						"Vous avez besoin d'une moyenne de " + twoDigits.format(z)
						+ "% dans les futures évaluations pour passer le cours.",
						"Note " + VERSION, JOptionPane.PLAIN_MESSAGE);
			} 
		}
	}
}