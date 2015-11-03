package pkNatoGame;
import java.util.*;
import javax.swing.*;

public class NatoGame {

	// Game Initialization
	static String[] sMoves = { null, null, null, null };
	static int[] iMoves = { 0, 0, 0, 0 };
	static String sMove = null;
	static int iMove = 0;

	static boolean isLegit = true;
	static Random nextInt = new Random();

	// Moves
	static Move[] oMoves = { new Move("Splash", 0, -1),
		/*1*/	new Move("Sword", 20, 0),
		/*2*/	new Move("Fireball", 35, 50), // TODO : Burn
		/*3*/	new Move("Bow", 42, 10),
		/*4*/	new Move("Ice Bolt", 15, 25), // TODO : Frozen
		/*5*/	new Move("Sacrificial Dagger", 10, -10),
		/*6*/	new Move("Tackle", 10, 1),
		/*7*/	new Move("Dagger", 15, 0),
		/*8*/	new Move("Body Slam", 25, 5)
	};

	// Player

	// Monsters : Name, HP, Mana, Level, M1, M2, M3, M4
	static Monster[] oMonsters = { new Monster("Slime", 50, 0, 1, 1, 0, 0, 0),
		new Monster("Skeleton Warrior", 100, 0, 1, 1, 6, 0, 0),
		new Monster("Skeleton Archer", 75, 80, 1, 3, 7, 0, 0),
		new Monster("Skeleton Mage", 50, 70, 1, 2, 4, 5, 0),
		new Monster("Orc", 150, 15, 1, 1, 8, 7, 6),
		new Monster("Peasant", 100, 100, 1, 1, 2, 7, 6)
	};

	static int iMonster = 0;

	public static void main(String[] args) {

		/*
		 * String[] sMainMenu = { "Create a new game", "Load a game" };
		 * 
		 * JOptionPane.showOptionDialog(null,
		 * "Create a new game or load a game?", "Main Menu",
		 * JOptionPane.YES_NO_OPTION, JOptionPane.PLAIN_MESSAGE, null,
		 * sMainMenu, sMainMenu);
		 */

		// Initialisation du Héro
		Player hero = new Player();

		// Sélection du monstre
		iMonster = nextInt.nextInt(oMonsters.length);
		oMonsters[iMonster].setxLevel(nextInt.nextInt(hero.getxLevel()) + 1);
		System.out.println(oMonsters[iMonster]);

		while (hero.getaHP() > 0 && oMonsters[iMonster].getaHP() > 0) {

			if (isLegit) {
				// Regen
				hero.regen();
				oMonsters[iMonster].regen();

				// Hero's Turn

				// Nom des moves
				sMoves[0] = oMoves[hero.getiMove1()].getName();
				sMoves[1] = oMoves[hero.getiMove2()].getName();
				sMoves[2] = oMoves[hero.getiMove3()].getName();
				sMoves[3] = oMoves[hero.getiMove4()].getName();

				// ID des moves
				iMoves[0] = hero.getiMove1();
				iMoves[1] = hero.getiMove2();
				iMoves[2] = hero.getiMove3();
				iMoves[3] = hero.getiMove4();
			}

			isLegit = true;
			// Boîte de dialogue
			iMove = JOptionPane.showOptionDialog(null, oMonsters[iMonster].toString() + "\n" + hero.getName() + " is awaiting for directions.", hero.toString(),
					JOptionPane.YES_NO_OPTION, JOptionPane.PLAIN_MESSAGE, null, sMoves, sMoves);

			// Vérification du coût de la mana
			if (hero.getaMana() <= oMoves[iMoves[iMove]].getCost()) {
				isLegit = false;
				continue;
			}

			// Mana Cost & Damage Done
			hero.loseMana(oMoves[iMoves[iMove]].getCost());
			oMonsters[iMonster].loseHP(oMoves[iMoves[iMove]].getDmg() * hero.getxLevel());

			// What happened during Player's turn
			System.out.println(hero.getName() + " utilise " + sMoves[iMove] + " pour " + oMoves[iMoves[iMove]].getDmg() * hero.getxLevel() + " dommages.");
			System.out.println(oMonsters[iMonster]);

			// Est-il mort?
			if (oMonsters[iMonster].getaHP() == 0)
				break;

			// Monster's Turn

			// Nom des moves
			sMoves[0] = oMoves[oMonsters[iMonster].getiMove1()].getName();
			sMoves[1] = oMoves[oMonsters[iMonster].getiMove2()].getName();
			sMoves[2] = oMoves[oMonsters[iMonster].getiMove3()].getName();
			sMoves[3] = oMoves[oMonsters[iMonster].getiMove4()].getName();

			// ID des moves
			iMoves[0] = oMonsters[iMonster].getiMove1();
			iMoves[1] = oMonsters[iMonster].getiMove2();
			iMoves[2] = oMonsters[iMonster].getiMove3();
			iMoves[3] = oMonsters[iMonster].getiMove4();

			// Monster's move
			do {
				iMove = (int) nextInt.nextInt(iMoves.length);
			} while (oMoves[iMoves[iMove]].getDmg() == 0
					|| oMoves[iMoves[iMove]].getCost() > oMonsters[iMonster].getaMana());

			// Mana Cost & Damage Done
			oMonsters[iMonster].loseMana(oMoves[iMoves[iMove]].getCost());
			hero.loseHP(oMoves[iMoves[iMove]].getDmg() * oMonsters[iMonster].getxLevel());

			// What happened during Monster's turn
			System.out.println(oMonsters[iMonster].getName() + " utilise " + sMoves[iMove] + " pour " + oMoves[iMoves[iMove]].getDmg() * oMonsters[iMonster].getxLevel() + " dommages.");
			System.out.println(hero);

		}

		// Victory/Defeat
		if (hero.getaHP() <= 0)
			JOptionPane.showMessageDialog(null, "Vous avez perdu!", "Défaite", JOptionPane.PLAIN_MESSAGE);
		else if (oMonsters[iMonster].getaHP() <= 0)
			JOptionPane.showMessageDialog(null, "Vous avez gagné!", "Victoire", JOptionPane.PLAIN_MESSAGE);
	}
}
