package com.natoboram.westerntea;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.PlayerDeathEvent;
import org.bukkit.event.player.PlayerQuitEvent;
public class Lightning implements Listener {
	@EventHandler
	public void onPlayerDeath(PlayerDeathEvent event) {
		// LightningBolt
		event.getEntity().getWorld().strikeLightningEffect(event.getEntity().getLocation());
	}
	@EventHandler
	public void onPlayerQuit(PlayerQuitEvent event) {
		// LightningBolt
		event.getPlayer().getWorld().strikeLightningEffect(event.getPlayer().getLocation());
	}
}