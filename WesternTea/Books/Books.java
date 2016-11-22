package com.natoboram.westerntea;
import org.bukkit.plugin.java.JavaPlugin;
public class Books extends JavaPlugin {
	@Override
	public void onEnable() {
		// Enable Listeners
		getServer().getPluginManager().registerEvents(new GroundSpells(), this);
		getServer().getPluginManager().registerEvents(new EntitySpells(), this);
	}
}
