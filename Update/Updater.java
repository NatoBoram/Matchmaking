package pkUpdater;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.net.MalformedURLException;
import java.net.URL;
public class Updater {
	public static void update(final String PROJECTNAME, final String VERSION) {
		try {
			// Variables
			final URL VERSIONURL = new URL("https://raw.githubusercontent.com/NatoBoram/Update/master/" + PROJECTNAME + "/version.txt");
			final URL DOWNLOADLINK = new URL("https://github.com/NatoBoram/Update/raw/master/" + PROJECTNAME + "/" + PROJECTNAME + ".jar");
			String LATESTVERSION = "";
			int c = 0;
			System.out.println("Current : " + VERSION);
			// Get Latest Version
			InputStream versionStream = VERSIONURL.openStream();
			while ((c = versionStream.read()) != -1) {
				LATESTVERSION += (char) c;
			}
			versionStream.close();
			System.out.println("Latest : " + LATESTVERSION);
			// Time to update!
			if (LATESTVERSION != null && !VERSION.equals(LATESTVERSION)) {
				// Download
				InputStream downloadStream = DOWNLOADLINK.openStream();
				OutputStream downloadOutput = new FileOutputStream(new File(System.getProperty("user.dir") + File.separator + PROJECTNAME + ".jar"), false);
				c = 0;
				while ((c = downloadStream.read()) != -1) {
					downloadOutput.write(c);
				}
				downloadOutput.flush();
				downloadOutput.close();
				downloadStream.close();
				System.out.println("Updated");
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
}