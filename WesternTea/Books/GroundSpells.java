package com.natoboram.westerntea;
import java.util.ArrayList;
import java.util.List;
import org.bukkit.Material;
import org.bukkit.entity.EntityType;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.inventory.meta.BookMeta;
public class GroundSpells implements Listener {

	@EventHandler
	public void onPlayerInteract(PlayerInteractEvent event) {
		if (!valid(event)) return;
		BookMeta b = (BookMeta) event.getItem().getItemMeta();
		// Was the user the author of the book?
		if (b.getAuthor().equals(event.getPlayer().getName())) {

			// Spells
			if (b.getPage(1).equals("Magna Tonitrus")) // Lightning Bolt!
				event.getClickedBlock().getWorld().strikeLightning(event.getClickedBlock().getLocation());
			else if (b.getPage(1).equals("Avis")) // Bats!
				for (int c = 0; c < 10; c++)
					event.getPlayer().getWorld().spawnEntity(event.getPlayer().getLocation(), EntityType.BAT);

			consume(event);
		} else if (!b.getAuthor().equals(event.getPlayer().getName())) {
			// Don't use MY book!
			event.getPlayer().getWorld().strikeLightning(event.getPlayer().getLocation());
		}
	}

	// Check if the returned event is valid
	private boolean valid(PlayerInteractEvent event) {
		// Was the player holding an item?
		if (event.hasItem() && event.getClickedBlock() != null) 
			// Was the item involved a book?
			if (event.getMaterial() == Material.WRITTEN_BOOK && event.getItem().hasItemMeta()) {
				// BookMeta Cast ItemMeta
				BookMeta b = (BookMeta) event.getItem().getItemMeta();
				// Does it have a title and an author?
				if (b.hasTitle() && b.hasAuthor() && b.hasGeneration()) 
					// Was the title "Book of Shadows"? Was it an original book?
					if (b.getTitle().equals("Book of Shadows")
							&& b.getGeneration() == BookMeta.Generation.valueOf("ORIGINAL")) 
						return true;
			}
		return false;
	}

	// Burn either a page, either the whole book
	private void consume(PlayerInteractEvent event) {
		// BookMeta Cast ItemMeta
		BookMeta b = (BookMeta) event.getItem().getItemMeta();
		if (b.getPageCount() > 1) {
			// First page is burnt upon use
			List<String> pages = new ArrayList<String>(b.getPages());
			pages.remove(1);
			b.setPages(pages);
			event.getItem().setItemMeta(b);
		} else {
			// Destroy Book
			event.getItem().setAmount(-1);
		}
	}
}
