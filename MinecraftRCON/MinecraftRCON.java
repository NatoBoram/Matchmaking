/**
 * MinecraftRCON by NatoBoram
 * https://github.com/NatoBoram/
 * 
 * Thanks to RedXVIII for his source code on Minecraft Forum.
 * http://www.minecraftforum.net/forums/support/server-support/1881587-java-rcon-for-minecraft
 * 
 * Thanks to SamLebarbare for his source code on Github.
 * https://github.com/SamLebarbare/minecraft-frontend/blob/master/app/rcon/MinecraftRcon.java
 */

package pkMinecraftRCON;
import java.io.*;
import java.net.*;
import java.nio.*;
import java.util.*;
import javax.swing.*;
import pkUpdate.Updater;

@SuppressWarnings("unchecked")
public class MinecraftRCON {

	// VARIABLES
	static final String PROJECTNAME = "MinecraftRCON";
	static final String VERSION = "1.1.0";
	static ArrayList<Server> ServerList = new ArrayList<Server>();

	final static int SERVERDATA_EXECCOMMAND = 2;
	final static int SERVERDATA_AUTH = 3;
	final static int SERVERDATA_RESPONSE_VALUE = 0;
	final static int SERVERDATA_AUTH_RESPONSE = 2;

	final static int RESPONSE_TIMEOUT = 2000;
	final static int MULTIPLE_PACKETS_TIMEOUT = 300;

	static Socket rconSocket = null;
	static InputStream in = null;
	static OutputStream out = null;

	// BLACK MAGIC 
	static void read() {
		try {
			// Server
			FileInputStream fileIn = new FileInputStream("C:/Nato/" + PROJECTNAME + "/servers.ser");
			ObjectInputStream in = new ObjectInputStream(fileIn);
			ServerList = (ArrayList<Server>) in.readObject();
			in.close();
			fileIn.close();

		} catch(FileNotFoundException e) {
			write();
		} catch (IOException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	static void write() {
		try {
			// Server
			FileOutputStream fileOut = new FileOutputStream("C:/Nato/" + PROJECTNAME + "/servers.ser");
			ObjectOutputStream out = new ObjectOutputStream(fileOut);
			out.writeObject(ServerList);
			out.close();
			fileOut.close();

		} catch(IOException e) {
			new File("C:/Nato").mkdirs();
			new File("C:/Nato/" + PROJECTNAME).mkdirs();
		}
	}

	// Copy + Paste
	public static String send(Server server, String command) throws IOException {
		String response = "";

		try {
			rconSocket = new Socket(InetAddress.getByName(server.getIp()), Integer.parseInt(server.getPort()));
		} catch (UnknownHostException e) {
			return "Invalid IP Adress";
		}

		out = rconSocket.getOutputStream();
		in = rconSocket.getInputStream();
		rconSocket.setSoTimeout(RESPONSE_TIMEOUT);

		if (rcon_auth(server.getPassword())) {

			// We are now authenticated
			ByteBuffer[] resp = sendCommand(command);

			// Close socket handlers, we don't need them more
			out.close();
			in.close();
			rconSocket.close();

			if (resp != null)
				response = assemblePackets(resp);
			if (response.length() == 0) System.out.println("Empty");
			else {
				JOptionPane.showMessageDialog(null, response, "RCON", JOptionPane.PLAIN_MESSAGE);
				server.addCountCommands();
			}

		} else {
			System.out.println("Wrong Password");
		}

		return response;
	}

	private static ByteBuffer[] sendCommand(String command) throws IOException {

		byte[] request = constructPacket(2, SERVERDATA_EXECCOMMAND, command);

		ByteBuffer[] resp = new ByteBuffer[128];
		int i = 0;
		out.write(request);
		resp[i] = receivePacket(); // First and maybe the unique response packet
		try {
			// We don't know how many packets will return in response, so we'll
			// read() the socket until TimeoutException occurs.
			rconSocket.setSoTimeout(MULTIPLE_PACKETS_TIMEOUT);
			while (true) {
				resp[++i] = receivePacket();
			}
		} catch (SocketTimeoutException e) {
			// No more packets in the response, go on
			return resp;
		}
	}

	private static byte[] constructPacket(int id, int cmdtype, String s1) {

		ByteBuffer p = ByteBuffer.allocate(s1.length() + 16);
		p.order(ByteOrder.LITTLE_ENDIAN);

		// length of the packet
		p.putInt(s1.length() + 12);
		// request id
		p.putInt(id);
		// type of command
		p.putInt(cmdtype);
		// the command itself
		p.put(s1.getBytes());
		// two null bytes at the end
		p.put((byte) 0x00);
		p.put((byte) 0x00);
		// null string2 (see Source protocol)
		p.put((byte) 0x00);
		p.put((byte) 0x00);

		return p.array();
	}

	private static ByteBuffer receivePacket() throws IOException {

		ByteBuffer p = ByteBuffer.allocate(5120);
		p.order(ByteOrder.LITTLE_ENDIAN);

		byte[] length = new byte[4];

		if (in.read(length, 0, 4) != 4) {
			return null;
		}

		// Now we've the length of the packet, let's go read the bytes
		p.put(length);
		int i = 0;
		while (i < p.getInt(0)) {
			p.put((byte) in.read());
			i++;
		}
		return p;
	}

	private static String assemblePackets(ByteBuffer[] packets) {
		// Return the text from all the response packets together
		String response = "";
		for (int i = 0; i < packets.length; i++) {
			if (packets[i] != null) {
				response = response.concat(new String(packets[i].array(), 12, packets[i].position() - 14));
			}
		}
		return response;
	}

	private static boolean rcon_auth(String rcon_password) throws IOException {

		byte[] authRequest = constructPacket(0, SERVERDATA_AUTH, rcon_password);
		System.out.println("AuthRequest:" + authRequest.toString());
		ByteBuffer response = ByteBuffer.allocate(64);
		out.write(authRequest);
		response = receivePacket(); // junk response packet

		// Lets see if the received request_id is leet enougth ;)
		if ((response.getInt(4) == 0) && (response.getInt(8) == SERVERDATA_AUTH_RESPONSE)) {
			return true;
		}

		return false;
	}

	// METHODS

	static void ForeverAlone() {
		JOptionPane.showMessageDialog(null, "There are no servers to select from.", "Error", JOptionPane.ERROR_MESSAGE);
	}

	static Server selectServer() {

		if (ServerList.size() == 0) {
			ForeverAlone();
			return null;
		}

		String server = (String) JOptionPane.showInputDialog(null, "Select Server", "RCON", JOptionPane.PLAIN_MESSAGE, null, toTable(ServerList), toTable(ServerList)[0]);

		if (server == null) return null;

		for (int c = 0; c < ServerList.size(); c++) if (server.equals(ServerList.get(c).toString())) return ServerList.get(c);
		return null;
	}

	// INTERFACES
	static void commandsInterface(Server server) {

		if (server == null) return;
		server.addCountConnections();

		while(true) {
			String command = (String) JOptionPane.showInputDialog(null, "Command", "RCON", JOptionPane.PLAIN_MESSAGE);

			if (command == null) break;
			else if (command.length() <= 0) continue;

			try {
				send(server, command);
			} catch (IOException e) {
				e.printStackTrace();
			}

		}
	}

	static void addServer() {
		String name = (String) JOptionPane.showInputDialog(null, "Server's Name", "RCON", JOptionPane.PLAIN_MESSAGE);
		if (name == null || name.length() <= 0) return;

		String ip = (String) JOptionPane.showInputDialog(null, "Server's IP Adress", "RCON", JOptionPane.PLAIN_MESSAGE, null, null, "127.0.0.1");
		if (ip == null || ip.length() <= 0) return;

		String port = (String) JOptionPane.showInputDialog(null, "RCON's Port", "RCON", JOptionPane.PLAIN_MESSAGE, null, null, "25575");
		if (port == null || port.length() <= 0) return;

		String password = (String) JOptionPane.showInputDialog(null, "RCON's Password", "RCON", JOptionPane.PLAIN_MESSAGE);
		if (password == null || password.length() <= 0) return;

		ServerList.add(new Server(name, ip, port, password));
	}

	static void removeServer() {
		if (ServerList.size() == 0) {
			ForeverAlone();
			return;
		}
		String name = (String) JOptionPane.showInputDialog(null, "Server", "Remove Server", JOptionPane.PLAIN_MESSAGE, null, toTable(ServerList), toTable(ServerList)[0]);
		for (int c = 0; c < ServerList.size(); c++) {
			if (ServerList.get(c).toString().equals(name) || ServerList.get(c).toString().equals(null)) ServerList.remove(c);
		}
	}

	static void serverList() {
		if (ServerList.size() == 0) {
			ForeverAlone();
			return;
		}
		String MESSAGE = "";
		for (int c = 0; c < ServerList.size(); c++) {
			MESSAGE += ServerList.get(c).toString() + "\n";
		}
		JOptionPane.showMessageDialog(null, MESSAGE, "Server List", JOptionPane.PLAIN_MESSAGE);
	}

	// Shenanigans
	static String[] toTable(ArrayList<Server> array) {
		String[] table = new String[array.size()];
		for (int c = 0; c < array.size(); c++) {
			if (array.get(c).toString().equals(null) || array.get(c).toString() == null) array.remove(c);
			else table[c] = array.get(c).toString();
		}
		return table;
	}

	public static void main(String[] args) throws IOException {

		Updater.update(PROJECTNAME, VERSION);
		read();

		String[] options = {"Select Server", "Add Server", "Remove Server", "Server List"};

		while(true) {
			write();
			// menu.setVisible(true);
			int option = JOptionPane.showOptionDialog(/*menu*/null, "Main Menu", PROJECTNAME + " " + VERSION, JOptionPane.PLAIN_MESSAGE, JOptionPane.PLAIN_MESSAGE, null, options, options[0]);
			if (option == -1) break; // It's the X button
			else if (options[option] == "Select Server") commandsInterface(selectServer());
			else if (options[option] == "Add Server") addServer();
			else if (options[option] == "Remove Server") removeServer();
			else if (options[option] == "Server List") serverList();
			Collections.sort(ServerList);
		}
	}
}
