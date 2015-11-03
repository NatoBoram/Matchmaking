package pkNatoGame;

public class Move {
	private String name;
	private int dmg, cost;
	private String type;

	public Move(String name, int dmg, int cost) {
		this.name = name;
		this.dmg = dmg;
		this.cost = cost;
	}
	public Move(String name, int dmg, int cost, String type) {
		this.name = name;
		this.dmg = dmg;
		this.cost = cost;
		if (type != "physical" && type != "magical" && type != "true")
			this.type = "true";
		else this.type = type;
	}

	// Get

	public String getName() {
		return name;
	}

	public int getDmg() {
		return dmg;
	}

	public int getCost() {
		return cost;
	}

	// toString

	public String toString() {
		return name + " : " + dmg + " Damage, " + cost + " Mana";
	}

}
