package com.natoboram.westerntea;
import org.bukkit.Bukkit;
import org.bukkit.event.EventHandler;
import org.bukkit.event.Listener;
import org.bukkit.event.player.PlayerQuitEvent;

public class Shutdown implements Listener {
	@EventHandler
	public void onPlayerQuit(PlayerQuitEvent event) {
		// Shutdown
		if (Bukkit.getOnlinePlayers().size() <= 1) {
			event.getPlayer().getWorld().setTime(0);
			Bukkit.shutdown();
		}
	}
}