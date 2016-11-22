package com.natoboram.westerntea;
import java.util.ArrayList;
import java.util.List;
import java.util.Random;
import org.bukkit.Color;
import org.bukkit.Material;
import org.bukkit.entity.EntityType;
import org.bukkit.entity.LivingEntity;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerInteractEntityEvent;
import org.bukkit.inventory.EquipmentSlot;
import org.bukkit.inventory.ItemStack;
import org.bukkit.inventory.meta.BookMeta;
import org.bukkit.potion.PotionEffect;
import org.bukkit.potion.PotionEffectType;
public class EntitySpells implements Listener {

	@EventHandler
	public void onPlayerInteractAtEntity(PlayerInteractEntityEvent event) {
		// Get Item
		ItemStack s;
		if (event.getHand() == EquipmentSlot.HAND)
			s = event.getPlayer().getInventory().getItemInMainHand();
		else if (event.getHand() == EquipmentSlot.OFF_HAND)
			s = event.getPlayer().getInventory().getItemInOffHand();
		else return;

		// Written Book? Has Item Meta? Has Right Clicked?
		if (s.getType() == Material.WRITTEN_BOOK
				&& s.hasItemMeta()
				&& event.getRightClicked() != null) {
			// Cast
			BookMeta b = (BookMeta) s.getItemMeta();
			// Has Author? Has Title? Has Generation? RightClicked isLivingEntity?
			if (b.hasTitle() && b.hasAuthor() && b.hasGeneration() && isLivingEntity(event)) {
				// Book of Shadows? Original?
				if (b.getTitle().equals("Book of Shadows")
						&& b.getGeneration() == BookMeta.Generation.valueOf("ORIGINAL"))
					// Was the user the author of the book?
					if (b.getAuthor().equals(event.getPlayer().getName())) {

						// Spells targeted at entities
						if (b.getPage(1).equals(null)) s.setAmount(-1);

						// Minecraft
						else if (b.getPage(1).equals("Absorption")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.ABSORPTION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x2552A5)));
						else if (b.getPage(1).equals("Bad Luck")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.UNLUCK, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xC0A44D)));
						else if (b.getPage(1).equals("Blindness")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.BLINDNESS, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x1F1F23)));
						else if (b.getPage(1).equals("Fire Resistance")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.FIRE_RESISTANCE, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xE49A3A)));
						else if (b.getPage(1).equals("Glowing")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.GLOWING, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x94A061)));
						else if (b.getPage(1).equals("Haste")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.FAST_DIGGING, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xD9C043)));
						else if (b.getPage(1).equals("Health Boost")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.HEALTH_BOOST, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xF87D23)));
						else if (b.getPage(1).equals("Hunger")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.HUNGER, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x587653)));
						else if (b.getPage(1).equals("Instant Damage")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.HARM, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x430A09)));
						else if (b.getPage(1).equals("Instant Health")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.HEAL, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xF82423)));
						else if (b.getPage(1).equals("Invisibility")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.INVISIBILITY, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x7F8392)));
						else if (b.getPage(1).equals("Jump Boost")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.JUMP, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x786297)));
						else if (b.getPage(1).equals("Levitation")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.LEVITATION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xCEFFFF)));
						else if (b.getPage(1).equals("Luck")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.LUCK, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x339900)));
						else if (b.getPage(1).equals("Mining Fatigue")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.SLOW_DIGGING, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x4A4217)));
						else if (b.getPage(1).equals("Nausea")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.CONFUSION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x551D4A)));
						else if (b.getPage(1).equals("Night Vision")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.NIGHT_VISION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x1F1FA1)));
						else if (b.getPage(1).equals("Poison")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.POISON, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x4E9331)));
						else if (b.getPage(1).equals("Regeneration")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.REGENERATION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xCD5CAB)));
						else if (b.getPage(1).equals("Resistance")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.DAMAGE_RESISTANCE, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x99453A)));
						else if (b.getPage(1).equals("Saturation")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.SATURATION, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0xF82423)));
						else if (b.getPage(1).equals("Slowness")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.SLOW, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x5A6C81)));
						else if (b.getPage(1).equals("Speed")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.SPEED, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x7CAFC6)));
						else if (b.getPage(1).equals("Strength")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.INCREASE_DAMAGE, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x932423)));
						else if (b.getPage(1).equals("Water Breathing")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.WATER_BREATHING, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x2E5299)));
						else if (b.getPage(1).equals("Weakness")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.WEAKNESS, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x484D48)));
						else if (b.getPage(1).equals("Wither")) ((LivingEntity) event.getRightClicked()).addPotionEffect(new PotionEffect(PotionEffectType.WITHER, (new Random()).nextInt(20*event.getPlayer().getLevel()), (new Random()).nextInt(1+event.getPlayer().getLevel()), false, true, Color.fromRGB(0x352A27)));

						// Harry Potter
						else if (b.getPage(1).equals("Nasus Vespertilionem")) for (int c = 0; c < 2; c++) event.getRightClicked().getWorld().spawnEntity(event.getRightClicked().getLocation(), EntityType.BAT);

						if (b.getPageCount() > 1) {
							// First page is burnt upon use
							List<String> pages = new ArrayList<String>(b.getPages());
							pages.remove(1);
							b.setPages(pages);
							s.setItemMeta(b);
							// Applying changes
							if (event.getHand() == EquipmentSlot.HAND)
								event.getPlayer().getInventory().setItemInMainHand(s);
							else if (event.getHand() == EquipmentSlot.OFF_HAND)
								event.getPlayer().getInventory().setItemInOffHand(s);
						} else {
							// Destroy book
							s.setAmount(-1);
							// Applying changes
							if (event.getHand() == EquipmentSlot.HAND)
								event.getPlayer().getInventory().setItemInMainHand(s);
							else if (event.getHand() == EquipmentSlot.OFF_HAND)
								event.getPlayer().getInventory().setItemInOffHand(s);
						}
					} else if (!b.getAuthor().equals(event.getPlayer().getName())) {
						// Don't use MY book!
						event.getPlayer().getWorld().strikeLightning(event.getPlayer().getLocation());
					}
			}
		}
	}

	private boolean isLivingEntity(PlayerInteractEntityEvent event) {
		switch (event.getRightClicked().getType()) {
		case BAT: return true;
		case BLAZE: return true;
		case CAVE_SPIDER : return true;
		case CHICKEN : return true;
		case COW : return true;
		case CREEPER : return true;
		case DONKEY: return true;
		case ELDER_GUARDIAN : return true;
		case ENDER_DRAGON : return true;
		case ENDERMAN : return true;
		case ENDERMITE : return true;
		case EVOKER : return true;
		case GHAST : return true;
		case GIANT : return true;
		case GUARDIAN : return true;
		case HORSE : return true;
		case HUSK : return true;
		case IRON_GOLEM : return true;
		case LLAMA : return true;
		case MAGMA_CUBE : return true;
		case MULE : return true;
		case MUSHROOM_COW : return true;
		case OCELOT : return true;
		case PIG : return true;
		case PIG_ZOMBIE : return true;
		case PLAYER : return true;
		case POLAR_BEAR : return true;
		case RABBIT : return true;
		case SHEEP : return true;
		case SHULKER : return true;
		case SILVERFISH : return true;
		case SKELETON : return true;
		case SKELETON_HORSE : return true;
		case SLIME : return true;
		case SNOWMAN : return true;
		case SPIDER : return true;
		case SQUID: return true;
		case STRAY : return true;
		case VEX : return true;
		case VILLAGER : return true;
		case VINDICATOR : return true;
		case WITCH : return true;
		case WITHER : return true;
		case WITHER_SKELETON : return true;
		case WOLF : return true;
		case ZOMBIE : return true;
		case ZOMBIE_HORSE : return true;
		case ZOMBIE_VILLAGER : return true;
		default : return false;
		}
	}
}
