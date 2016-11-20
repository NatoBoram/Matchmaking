package com.natoboram.westerntea;
import org.bukkit.Bukkit;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.entity.PlayerDeathEvent;
import org.bukkit.event.player.PlayerQuitEvent;

public class Listeners implements Listener {
	@EventHandler
	public void onPlayerDeath(PlayerDeathEvent event) {
		// LightningBolt
		event.getEntity().getWorld().strikeLightningEffect(event.getEntity().getLocation());
	}

	@EventHandler
	public void onPlayerQuit(PlayerQuitEvent event) {
		// LightningBolt
		event.getPlayer().getWorld().strikeLightningEffect(event.getPlayer().getLocation());

		// Shutdown
		if (Bukkit.getOnlinePlayers().size() <= 1) {
			event.getPlayer().getWorld().setTime(0);
			Bukkit.shutdown();
		}
	}
}
