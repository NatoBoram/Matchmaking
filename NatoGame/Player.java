package pkNatoGame;

public class Player extends Entity {

	// New Game
	public Player() {
		super("Hero");
		setxHP(100);
		setxMana(100);
		setxLevel(1);
		setaXP(0);
		setMaxValue();
		setiMove1(1);
		setiMove2(2);
		setiMove3(0);
		setiMove4(0);
	}

	// Load Game
	public Player(String name, int xHP, int xMana, int xLevel, int aXP,
			int iMove1, int iMove2, int iMove3, int iMove4) {
		super();
		setName(name);
		setxHP(xHP);
		setxMana(xMana);
		setxLevel(xLevel);
		setaXP(aXP);
		setMaxValue();
		setiMove1(iMove1);
		setiMove2(iMove2);
		setiMove3(iMove3);
		setiMove4(iMove4);
	}

}
