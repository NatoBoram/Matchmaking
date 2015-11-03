package pkNatoGame;

public class Monster extends Entity {

	public Monster(String aName, int xHP, int xMana, int xLevel, int iMove1,
			int iMove2, int iMove3, int iMove4) {
		setName(aName);
		setxHP(xHP);
		setxMana(xMana);
		setxLevel(xLevel);
		setMaxValue();
		setiMove1(iMove1);
		setiMove2(iMove2);
		setiMove3(iMove3);
		setiMove4(iMove4);
	}
}
