package pkNote;
import java.io.IOException;
import java.text.*;
import javax.swing.*;
import pkUpdater.*;

public class Note {

	final static String PROJECTNAME = "Note";
	final static String VERSION = "1.0.0";

	public static void main(String[] args) throws IOException {
		Updater.update(PROJECTNAME, VERSION);

		DecimalFormat twoDigits = new DecimalFormat ("0.00");

		double x = Double.parseDouble(JOptionPane.showInputDialog(null, "Points accumulés jusqu'à maintenant", "Note " + VERSION, JOptionPane.PLAIN_MESSAGE));
		double y = Double.parseDouble(JOptionPane.showInputDialog(null, "Points totaux évalués jusqu'à maintenant", "Note " + VERSION, JOptionPane.PLAIN_MESSAGE));

		x = 60-x;
		y = 100-y;
		double z = 100*(x/y);

		if (z > 100) {
			JOptionPane.showMessageDialog(null, "It's too late to apologize…", "You failed!", JOptionPane.ERROR_MESSAGE);
		} else if (z <= 0) {
			JOptionPane.showMessageDialog(null, "Vous avez déjà passé le cours!", "Félicitation!", JOptionPane.PLAIN_MESSAGE);
		} else if (z >= 60) {
			JOptionPane.showMessageDialog(null, "Vous avez besoin d'une moyenne de " + twoDigits.format(z) + "% dans les futures évaluations pour passer le cours.",
					"Attention!", JOptionPane.WARNING_MESSAGE);
		} else {
			JOptionPane.showMessageDialog(null, "Vous avez besoin d'une moyenne de " + twoDigits.format(z) + "% dans les futures évaluations pour passer le cours.",
					"Note " + VERSION, JOptionPane.PLAIN_MESSAGE);

		}
	}
}