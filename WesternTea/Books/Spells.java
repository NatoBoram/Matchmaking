package com.natoboram.westerntea;
import java.util.ArrayList;
import java.util.List;
import org.bukkit.Material;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerInteractEvent;
import org.bukkit.inventory.meta.BookMeta;
public class Spells implements Listener {
	@EventHandler
	public void onPlayerInteract(PlayerInteractEvent event) {

		// Was the player holding an item?
		if (event.hasItem() && event.getClickedBlock() != null) {

			// Was the item involved a book?
			if (event.getMaterial() == Material.WRITTEN_BOOK && event.getItem().hasItemMeta()) {

				// BookMeta Cast ItemMeta
				BookMeta b = (BookMeta) event.getItem().getItemMeta();

				// Does it have a title and an author?  Was it an original book?
				if (b.hasTitle() && b.hasAuthor() && b.hasGeneration()) {

					// Was the title "Book of Shadows"?
					if (b.getTitle().equals("Book of Shadows")
							&& b.getGeneration() == BookMeta.Generation.valueOf("ORIGINAL")) {

						// Was the user the author of the book?
						if (b.getAuthor().equals(event.getPlayer().getName())) {

							// TODO : Last page determines the spell.
							// Last page is burnt upon use
							if (b.getPageCount() > 1) {

								// TODO : Drop a sheet
								// Remove last page
								List<String> pages = new ArrayList<String>(b.getPages());
								pages.remove(pages.size() - 1);
								b.setPages(pages);
								event.getItem().setItemMeta(b);

							} else {
								
								// Destroy Book
								event.getItem().setAmount(-1);
							}

							// Lightning Bolt!
							event.getClickedBlock().getWorld().strikeLightning(event.getClickedBlock().getLocation());

						} else if (!b.getAuthor().equals(event.getPlayer().getName())) {

							// Don't use MY book!
							event.getPlayer().getWorld().strikeLightning(event.getPlayer().getLocation());
						}
					}
				}
			}
		}
	}
}
