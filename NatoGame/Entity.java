package pkNatoGame;

public abstract class Entity {

	private String name;
	private int xHP, xMana, xLevel; // X = Max at level 1
	private int aHP, aMana, aXP; // A = Actual
	private int iMove1, iMove2, iMove3, iMove4;

	public Entity() {
		super();
	}

	public Entity(String name) {
		super();
		this.name = name;
	}

	// Builds

	public void setMaxValue() {
		setaHP(getxHP() * getxLevel());
		setaMana(getxMana() * getxLevel());
	}

	public void regen() {
		aHP += xLevel;
		aMana += xLevel;
		if (aHP > xHP * xLevel)
			aHP = xHP * xLevel;
		if (aMana > xMana * xLevel)
			aMana = xMana * xLevel;
	}

	public void loseMana(int aMana) {
		this.aMana -= aMana;
	}

	public void loseHP(int aHP) {
		this.aHP -= aHP;
		if (this.aHP < 0)
			this.aHP = 0;
	}

	public void addXP(int aXP) {
		this.aXP += aXP;
		if (this.aXP > xLevel * 100) {
			this.aXP -= xLevel * 100;
			xLevel++;
		}
	}

	// GET

	public String getName() {
		return name;
	}

	public int getxHP() {
		return xHP;
	}

	public int getxMana() {
		return xMana;
	}

	public int getxLevel() {
		return xLevel;
	}

	public int getaHP() {
		return aHP;
	}

	public int getaMana() {
		return aMana;
	}

	public int getaXP() {
		return aXP;
	}

	public int getiMove1() {
		return iMove1;
	}

	public int getiMove2() {
		return iMove2;
	}

	public int getiMove3() {
		return iMove3;
	}

	public int getiMove4() {
		return iMove4;
	}

	// SET

	public void setName(String name) {
		this.name = name;
	}

	public void setxHP(int xHP) {
		this.xHP = xHP;
	}

	public void setxMana(int xMana) {
		this.xMana = xMana;
	}

	public void setxLevel(int xLevel) {
		this.xLevel = xLevel;
	}

	public void setaHP(int aHP) {
		this.aHP = aHP;
	}

	public void setaMana(int aMana) {
		this.aMana = aMana;
	}

	public void setaXP(int aXP) {
		this.aXP = aXP;
	}

	public void setiMove1(int iMove1) {
		this.iMove1 = iMove1;
	}

	public void setiMove2(int iMove2) {
		this.iMove2 = iMove2;
	}

	public void setiMove3(int iMove3) {
		this.iMove3 = iMove3;
	}

	public void setiMove4(int iMove4) {
		this.iMove4 = iMove4;
	}

	// toString
	public String toString() {
		return getName() + " : " + getaHP() + "/" + getxHP() * getxLevel()
				+ " Health, " + getaMana() + "/" + getxMana() * getxLevel()
				+ " Mana";
	}
}
