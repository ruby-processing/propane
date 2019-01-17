/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
  Part of the Processing project - http://processing.org

  Copyright (c) 2012-2014 The Processing Foundation
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


public class ThinkDifferent {

  private static Desktop desktop;
  private static Taskbar taskbar;
  static boolean attemptedQuit;


  static public void init(final PApplet sketch) {
    if (taskbar == null) {
      taskbar = Taskbar.getTaskbar();
    }
    if (desktop == null) {
      desktop = Desktop.getDesktop();
    }

    desktop.setQuitHandler((QuitEvent event, QuitResponse response) -> {
        sketch.exit();
        if (PApplet.uncaughtThrowable == null &&  // no known crash
                !attemptedQuit) {  // haven't tried yet
            response.cancelQuit();  // tell OS X we'll handle this
            attemptedQuit = true;
        } else {
            response.performQuit();  // just force it this time
        }
    });
  }

  static public void cleanup() {
    if (desktop == null) {
      desktop = Desktop.getDesktop();
    }
    desktop.setQuitHandler(null);
  }

  // Called via reflection from PSurfaceAWT and others
  static public void setIconImage(Image image) {
    taskbar.setIconImage(image);
  }
}
