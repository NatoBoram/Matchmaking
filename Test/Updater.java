package pkUpdate;
import java.io.*;
import java.net.*;
import javax.swing.*;

public class Updater {
	public static void update(final String PROJECTNAME, final String VERSION) throws IOException {

		// Variables
		final URL VERSIONURL = new URL("https://raw.githubusercontent.com/NatoBoram/Update/master/" + PROJECTNAME + "/version.txt");
		final URL DOWNLOADLINK = new URL("https://github.com/NatoBoram/Update/raw/master/" + PROJECTNAME + "/" + PROJECTNAME + ".jar");
		final String ROOT = "C:/Nato/" + PROJECTNAME + "/";
		new File("C:/Nato").mkdirs();
		new File(ROOT).mkdirs();
		int c = 0;

		try {

			// Get Latest Version
			InputStream versionStream = VERSIONURL.openStream();
			c = 0;
			StringBuffer versionBuffer = new StringBuffer("");
			while (c != -1) {
				c = versionStream.read();
				versionBuffer.append((char) c);
			}

			// Latest Version
			final String LATESTVERSION = versionBuffer.toString().substring(versionBuffer.toString().indexOf("[") + 1, versionBuffer.toString().indexOf("]"));
			versionStream.close();

			// Time to update!
			if (!VERSION.equals(LATESTVERSION)) {
				JOptionPane.showMessageDialog(null, "Updating to " + LATESTVERSION + ".", PROJECTNAME + " " + VERSION, JOptionPane.INFORMATION_MESSAGE);

				// Download
				URLConnection download = DOWNLOADLINK.openConnection();
				InputStream downloadStream = download.getInputStream();
				BufferedOutputStream downloadOutput = new BufferedOutputStream(new FileOutputStream(new File(ROOT + PROJECTNAME + ".jar")));
				byte[] downloadBuffer = new byte[32 * 1024];
				int bytesRead = 0;
				while ((bytesRead = downloadStream.read(downloadBuffer)) != -1) {
					downloadOutput.write(downloadBuffer, 0, bytesRead);
				}
				downloadOutput.flush();
				downloadOutput.close();
				downloadStream.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
			JOptionPane.showMessageDialog(null, "An error occured while preforming update!", "Error", JOptionPane.ERROR_MESSAGE);
		}
	}
}