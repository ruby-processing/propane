/*
  Was ThinkDifferent.java
  when part of the Processing project - http://processing.org

  Copyright (c) 2012-2019 The Processing Foundation
  Copyright (c) 2007-2012 Ben Fry and Casey Reas

  This program is free software; you can redistribute it and/or
  modify it under the terms of the GNU General Public License
  version 2, as published by the Free Software Foundation.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program; if not, write to the Free Software Foundation,
  Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */
package processing.core;

import java.awt.Image;
import java.awt.Taskbar;
import java.awt.Desktop;
import java.awt.desktop.QuitResponse;
import java.awt.desktop.QuitEvent;

/**
 * Deal with issues related to Mac OS window behavior.
 *
 * We have to register a quit handler to safely shut down the sketch,
 * otherwise OS X will just kill the sketch when a user hits Cmd-Q.
 * In addition, we have a method to set the dock icon image so we look more
 * like a native desktop.
 *
 * This is a stripped-down version of what's in processing.app.platform to fix
 * <a href="https://github.com/processing/processing/issues/3301">3301</a>.
 */

public class DesktopHandler {

    private static Desktop desktop;
    private static Taskbar taskbar;
    static boolean attemptedQuit;

    static public void init(final PApplet sketch) {
      getDesktop().setQuitHandler((event, quitResponse) -> {
        sketch.exit();

        boolean noKnownCrash = PApplet.uncaughtThrowable == null;

        if (noKnownCrash && !attemptedQuit) {  // haven't tried yet
          quitResponse.cancelQuit();  // tell OS X we'll handle this
          attemptedQuit = true;
        } else {
          quitResponse.performQuit();  // just force it this time
        }
      });
    }

    static public void cleanup() {
        getDesktop().setQuitHandler(null);
    }

    // Called via reflection from PSurfaceAWT and others
    static public void setIconImage(Image image) {
        taskbar.setIconImage(image);
    }

    /**
     * Get the taskbar where OS visual settings can be provided.
     *
     * @return Cached taskbar singleton instance.
     */
    static private Taskbar getTaskbar() {
      if (taskbar == null) {
        taskbar = Taskbar.getTaskbar();
      }
      return taskbar;
    }

    /**
     * Get the desktop where OS behavior can be provided.
     *
     * @return Cached desktop singleton instance.
     */
    static private Desktop getDesktop() {
      if (desktop == null) {
        desktop = Desktop.getDesktop();
      }
      return desktop;
    }
}
