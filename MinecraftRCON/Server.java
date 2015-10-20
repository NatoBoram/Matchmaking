package pkMinecraftRCON;
import java.io.*;

@SuppressWarnings("serial")
public class Server implements Serializable, Comparable<Server> {

	// The Server
	private String name;
	private String ip;
	private String port;
	private String password;

	// Statistics
	private int countConnections;
	private int countCommands;

	public Server(String name, String ip, String port, String password) {
		this.name = name;
		this.ip = ip;
		this.port = port;
		this.password = password;

		this.countConnections = 0;
		this.countCommands = 0;
	}

	public String getIp() {
		return ip;
	}
	public String getPort() {
		return port;
	}
	public String getPassword() {
		return password;
	}

	public int getCountConnections() {
		return countConnections;
	}
	public void addCountConnections() {
		this.countConnections++;
	}

	public int getCountCommands() {
		return countCommands;
	}
	public void addCountCommands() {
		this.countCommands++;
	}

	public String toString() {
		return name;
	}

	public int compareTo(Server other) {
		double s1 = this.getCountConnections() * this.getCountCommands();
		double s2 = other.getCountConnections() * other.getCountCommands();  
		if (s1 == s2)  return 0;
		else if (s1 < s2)  return 1;
		else if (s1 > s2)  return -1;
		else return 0;
	}
}