package pkUpdater;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.URL;
import java.net.URLConnection;

public class Updater {
	public static void update(final String PROJECTNAME, final String VERSION) throws IOException {

		// Variables
		final URL VERSIONURL = new URL("https://raw.githubusercontent.com/NatoBoram/Update/master/" + PROJECTNAME + "/version.txt");
		final URL DOWNLOADLINK = new URL("https://github.com/NatoBoram/Update/raw/master/" + PROJECTNAME + "/" + PROJECTNAME + ".jar");
		
		try {
			// Get Latest Version
			InputStream versionStream = VERSIONURL.openStream();
			StringBuffer versionBuffer = new StringBuffer("");
			int c = 0;
			while (c != -1) {
				c = versionStream.read();
				versionBuffer.append((char) c);
			}
			versionStream.close();
			final String LATESTVERSION = versionBuffer.toString().substring(versionBuffer.toString().indexOf("[") + 1, versionBuffer.toString().indexOf("]"));

			// Time to update!
			if (!VERSION.equals(LATESTVERSION)) {
				// Download
				URLConnection download = DOWNLOADLINK.openConnection();
				InputStream downloadStream = download.getInputStream();
				OutputStream downloadOutput = new FileOutputStream(new File(System.getProperty("user.dir") + File.separator + PROJECTNAME + ".jar"), false);
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
		}
	}
}
