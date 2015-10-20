package pkMatchmaking;
import pkUpdate.*;
import javax.swing.*;
import java.io.*;
import java.text.*;
import java.util.*;

@SuppressWarnings("unchecked")
public class Matchmaking {

	final static String PROJECTNAME = "Matchmaking";
	final static String VERSION = "1.2.2";
	static JFrame menu = new JFrame(PROJECTNAME);
	static DecimalFormat zeroDigits = new DecimalFormat ("0");
	static DecimalFormat twoDigits = new DecimalFormat ("0.00");
	static ArrayList<Friend> FriendList = new ArrayList<Friend>();

	// BLACK MAGIC 
	static void read() {
		try {
			FileInputStream fileIn = new FileInputStream("C:/Nato/" + PROJECTNAME + "/friends.ser");
			ObjectInputStream in = new ObjectInputStream(fileIn);
			FriendList = (ArrayList<Friend>) in.readObject();
			in.close();
			fileIn.close();
		} catch(IOException i) {
			i.printStackTrace();
			return;
		} catch(ClassNotFoundException c) {
			c.printStackTrace();
			return;
		}
	}

	// BLACK MAGIC
	static void write() {
		Collections.sort(FriendList);
		try {
			FileOutputStream fileOut = new FileOutputStream("C:/Nato/" + PROJECTNAME + "/friends.ser");
			ObjectOutputStream out = new ObjectOutputStream(fileOut);
			out.writeObject(FriendList);
			out.close();
			fileOut.close();
		} catch(IOException i) {
			new File("C:/Nato").mkdirs();
			new File("C:/Nato/" + PROJECTNAME).mkdirs();
		}
	}

	// Clean
	static void clean() {
		for (int c = 0; c < FriendList.size(); c++) {
			if (FriendList.get(c).toString() == null) FriendList.remove(c);
		}
	}

	// Shenanigans
	static String[] toTable(ArrayList<Friend> array) {
		String[] table = new String[array.size()];
		for (int c = 0; c < array.size(); c++) {
			if (array.get(c).toString().equals(null)) array.remove(c);
			table[c] = array.get(c).toString();
		}
		return table;
	}

	// Forever Alone
	static void ForeverAlone() {
		JOptionPane.showMessageDialog(null, "But you don't have any friends!", "Forever Alone", JOptionPane.ERROR_MESSAGE);
	}

	// MENU
	static void menu() {
		read();
		String[] options = {"Start Matchmaking", "Add Friend", "Remove Friend", "Friend List"};

		while(true) {	// Am I evil?
			clean();
			write();
			menu.setVisible(true);
			int option = JOptionPane.showOptionDialog(menu, "Main Menu", PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
			if (option == -1) return; // It's the X button
			else if (options[option] == "Start Matchmaking") lobby();
			else if (options[option] == "Add Friend") addFriend();
			else if (options[option] == "Remove Friend") removeFriend();
			else if (options[option] == "Friend List") friendList();
		}
	}

	// Add Friend
	static void addFriend() {
		FriendList.add(new Friend(JOptionPane.showInputDialog(null, "What's his name?", "Add Friend", JOptionPane.PLAIN_MESSAGE)));
	}

	// Remove Friend
	static void removeFriend() {
		if (FriendList.size() == 0) {
			ForeverAlone();
			return;
		}
		String name = (String) JOptionPane.showInputDialog(null, "What's his name?", "Remove Friend", JOptionPane.PLAIN_MESSAGE, null, toTable(FriendList), toTable(FriendList)[0]);
		for (int c = 0; c < FriendList.size(); c++) {
			if (FriendList.get(c).toString().equals(name)) FriendList.remove(c);
		}
	}

	// Friend List
	static void friendList() {
		if (FriendList.size() == 0) {
			ForeverAlone();
			return;
		}
		String MESSAGE = "";
		for (int c = 0; c < FriendList.size(); c++) {
			MESSAGE += FriendList.get(c).toString() + "\n";
			System.out.println(FriendList.get(c).toString() + " : " + zeroDigits.format(FriendList.get(c).getScore() * 100) + "%");
		}
		JOptionPane.showMessageDialog(null, MESSAGE, "Friend List", JOptionPane.PLAIN_MESSAGE);
	}

	// Start Matchmaking
	static void lobby() {
		if (FriendList.size() == 0) {
			ForeverAlone();
			return;
		}
		ArrayList<Friend> lobby = new ArrayList<Friend>();
		String[] options = {"Start Game", "Add to lobby", "Remove from lobby"};
		int option;

		while(true) {	// Moar evil!
			Collections.sort(lobby);
			menu.setVisible(true);

			String MESSAGE = "";
			for (int c = 0; c < lobby.size(); c++) {
				MESSAGE += lobby.get(c).toString() + "\n";
			}

			option = JOptionPane.showOptionDialog(null, MESSAGE, "lobby", JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
			if (option == -1) return;
			else if (options[option] == "Start Game") matchmaking(lobby);
			else if (options[option] == "Add to lobby") addlobby(lobby);
			else if (options[option] == "Remove from lobby") removelobby(lobby);
		}
	}

	// Add to lobby
	static void addlobby(ArrayList<Friend> lobby) {
		// Shenanigans
		String name = (String) JOptionPane.showInputDialog(null, "What's his name?", "Add to lobby", JOptionPane.PLAIN_MESSAGE, null, toTable(FriendList), toTable(FriendList)[0]);
		for (int i = 0; i < FriendList.size(); i++) {
			if (FriendList.get(i).toString().equals(name)) lobby.add(FriendList.get(i));
		}
	}

	// Remove from lobby
	static void removelobby(ArrayList<Friend> lobby) {
		if (lobby.size() == 0) return;
		String name = (String) JOptionPane.showInputDialog(null, "What's his name?", "Remove from lobby", JOptionPane.PLAIN_MESSAGE, null, toTable(lobby), toTable(lobby)[0]);
		for (int i = 0; i < lobby.size(); i++) {
			if (lobby.get(i).toString().equals(name)) lobby.remove(i);
		}
	}

	// Start Game
	static void matchmaking(ArrayList<Friend> lobby) {
		if (lobby.size() == 0) {
			ForeverAlone();
			return;
		}
		Collections.sort(lobby);
		menu.setVisible(false);

		// Create sides
		ArrayList<Friend> demacia = new ArrayList<Friend>();
		ArrayList<Friend> noxus = new ArrayList<Friend>();
		boolean jesus = false;

		// Sort
		for (int c = 0; c < lobby.size(); c++) {
			double ds = 0, ns = 0;
			for (int d = 0; d < demacia.size(); d++) {
				ds += demacia.get(d).getScore();
			}
			for (int n = 0; n < noxus.size(); n++) {
				ns += noxus.get(n).getScore();
			}

			// Bad luck?
			if (ds == ns) {
				if (demacia.size() + noxus.size() != 0) jesus = true;
				Random random = new Random();
				int side = random.nextInt(2);
				if (side == 0) demacia.add(lobby.get(c));
				else if (side == 1) noxus.add(lobby.get(c));
			}

			// Placing people
			else if (ds < ns) demacia.add(lobby.get(c));
			else if (ds > ns) noxus.add(lobby.get(c));
		}

		// Predictions
		double ds = 0, ns = 0;
		for (int d = 0; d < demacia.size(); d++) {
			ds += demacia.get(d).getScore();
		}
		for (int n = 0; n < noxus.size(); n++) {
			ns += noxus.get(n).getScore();
		}
		String PotentialWinner = "";
		if (ds == ns) PotentialWinner = "even";
		else if (ds < ns) PotentialWinner = "won by Noxus";
		else if (ds > ns) PotentialWinner = "won by Demacia";

		// Showing some love
		if (jesus && PotentialWinner != "even") JOptionPane.showMessageDialog(null, "Remember that this game is just for fun.", "Unbalanced teams", JOptionPane.ERROR_MESSAGE);
		String DEMACIA = "", NOXUS = "";
		for (int c = 0; c < demacia.size(); c++) {
			DEMACIA += demacia.get(c).toString() + ", ";
		}
		for (int c = 0; c < noxus.size(); c++) {
			NOXUS += noxus.get(c).toString() + ", ";
		}

		String[] options = {"Demacia", "Even", "Noxus"};
		int option = JOptionPane.showOptionDialog(null, "Demacia : \n"
				+ DEMACIA + "\n"
				+ "Noxus : \n"
				+ NOXUS + "\n"
				+ "\n"
				+ "The battle should be " + PotentialWinner + ".", "Let the battle begin!", JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, options, options[1]);

		if (option < 0) return;
		else if (options[option].equals("Even")) return;
		else if (options[option].equals("Demacia")) {
			winningTeam(demacia);
			losingTeam(noxus);
		}
		else if (options[option].equals("Noxus")) {
			winningTeam(noxus);
			losingTeam(demacia);
		}
		Collections.sort(FriendList);
	}

	static void winningTeam(ArrayList<Friend> team) {
		for (int c = 0; c < team.size(); c++) {
			team.get(c).won();
		}
	}
	static void losingTeam(ArrayList<Friend> team) {
		for (int c = 0; c < team.size(); c++) {
			team.get(c).lost();
		}
	}

	public static void main(String[] args) throws IOException {
		Updater.update(PROJECTNAME, VERSION);
		menu.setUndecorated(true);
		menu.setLocationRelativeTo(null);
		menu.setVisible(true);
		menu();
		menu.dispose();
		System.exit(0);
	}
}
