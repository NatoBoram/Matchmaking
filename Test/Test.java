package pkTest;
import java.io.IOException;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import pkUpdater.Updater;

public class Test {
	static final String PROJECTNAME = "Test";
	static final String VERSION = "1.3.0";

	public static void main(String[] args) throws IOException {
		JFrame menu = new JFrame(PROJECTNAME);
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);

		// Menu
		JOptionPane.showMessageDialog(menu, "Test", PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE);

		Updater.update(PROJECTNAME, VERSION);
		menu.dispose();
		System.exit(0);
	}
}