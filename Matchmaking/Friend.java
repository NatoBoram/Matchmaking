package pkMatchmaking;
import java.io.Serializable;

@SuppressWarnings({"serial"})
public class Friend implements Serializable, Comparable<Friend> {

	String name;
	int win, loss;

	Friend(String name) {
		this.name = name;
		this.win = 0;
		this.loss = 0;
	}

	// Methods
	public void won() {
		this.win++;
	}

	public void lost() {
		this.loss++;
	}

	public double getScore() {
		if (this.win + this.loss == 0) return 0;
		else return ((double) this.win / ((double) this.win + (double) this.loss));
	}

	// Footer
	public int compareTo(Friend other) {
		double s1 = this.getScore();
		double s2 = other.getScore();  
		if (s1 == s2)  return 0;
		else if (s1 < s2)  return 1;
		else if (s1 > s2)  return -1; 
		else return 0;
	}

	public String toString() {
		return name;
	}
}