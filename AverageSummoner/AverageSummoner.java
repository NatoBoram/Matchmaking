package pkAverageSummoner;
import java.io.IOException;
import javax.swing.JFrame;
import javax.swing.JOptionPane;
import pkUpdater.Updater;

/* Changelog
 * 1.0.0 : Updater
 * 1.0.1 : JFrame
 */

public class AverageSummoner {
	final static String PROJECTNAME = "AverageSummoner";
	final static String VERSION = "1.0.1";
	final static String[] LEVEL = { "No Account", "Level 1", "Level 2", "Level 3", "Level 4", "Level 5", "Level 6", "Level 7", "Level 8", "Level 9",
			"Level 10", "Level 11", "Level 12", "Level 13", "Level 14", "Level 15", "Level 16", "Level 17", "Level 18", "Level 19",
			"Level 20", "Level 21", "Level 22", "Level 23", "Level 24", "Level 25", "Level 26", "Level 27", "Level 28", "Level 29", "Unranked",
			"Bronze V", "Bronze IV", "Bronze III", "Bronze II", "Bronze I",
			"Silver V", "Silver IV", "Silver III", "Silver II", "Silver I",
			"Gold V", "Gold IV", "Gold III", "Gold II", "Gold I",
			"Platinum V", "Platinum IV", "Platinum III", "Platinum II", "Platinum I",
			"Diamond V", "Diamond IV", "Diamond III", "Diamond II", "Diamond I", 
			"Master", "Challenger" };
	static JFrame menu = new JFrame(PROJECTNAME);
	
	private static void exit() {
		menu.dispose();
		Updater.update(PROJECTNAME, VERSION);
		System.exit(0);
	}
	
	public static void main(String[] args) throws IOException {
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);
		
		while(true) {
			int x = 0;
			int avg = 0;
			try {
				x = Integer.parseInt(JOptionPane.showInputDialog(null, "How many summoners?", "AverageSummoner " + VERSION, JOptionPane.PLAIN_MESSAGE));
				// Each summoners
				for (int c = 1; c <= x; c++) {
					String sBuffer = JOptionPane.showInputDialog(null, "Rank", "Summoner #" + c, JOptionPane.PLAIN_MESSAGE, null, LEVEL, LEVEL[30]).toString();
					int y;
					for (y = 0; LEVEL[y] != sBuffer; y++);
					avg += y;
				}
				avg = (int) Math.round((double) avg / x);
				JOptionPane.showMessageDialog(null, "Average : " + LEVEL[avg], "AverageSummoner " + VERSION, JOptionPane.PLAIN_MESSAGE);
			} catch (NumberFormatException e) {
				exit();
			} catch (NullPointerException e) {
				exit();
			}
		}
	}
}