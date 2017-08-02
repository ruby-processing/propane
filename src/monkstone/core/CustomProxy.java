package monkstone.core;

import processing.core.PApplet;
import processing.event.KeyEvent;
import static processing.core.PConstants.*;

/**
 * The purpose of this class is to enable
 * access to processing keyEvent and draw? in propane
 * as a regular java library class.
 * Also included background, fill and stroke methods.
 * PConstants should also be available from static import
 * @author Martin Prout
 */
public abstract class CustomProxy {
private final PApplet app;

    /**
     * Useful accessors
     */
    public int width, height;

    /**
     *
     * @param app PApplet
     */
    public CustomProxy(PApplet app) {
        this.app = app;
        this.width = app.width;
        this.height = app.height;
        setActive(true);
    }


    /**
     * Register or unregister reflection methods
     * @param active
     */
    final void setActive(boolean active) {
        if (active) {
            this.app.registerMethod("dispose", this);
            this.app.registerMethod("keyEvent", this);
            this.app.registerMethod("draw", this);
        } else {
            this.app.unregisterMethod("draw", this);
            this.app.unregisterMethod("keyEvent", this);
        }
    }

    /**
     * Simple signature for background hides need to call app
     * @param col int
     */
    public void background(int col) {
        this.app.background(col);
    }

    /**
     * Simple signature for fill hides need to call app
     * @param col int
     */
    public void fill(int col) {
        this.app.fill(col);
    }

    /**
     * Simple signature for stroke hides need to call app
     * @param col int
     */
    public void stroke(int col) {
        this.app.stroke(col);
    }

    /**
     * Access applet if we must
     * @return applet PApplet
     */
    public PApplet app() {
        return this.app;
    }

    /**
     * Extending classes must implement this gives access to processing PApplet
     * draw loop
     */
    public abstract void draw();


    /**
     * Extending classes must implement this gives access to processing PApplet
     * keyEvent (more general than required for keyPressed)
     *
     * @param e KeyEvent
     */
    public abstract void keyEvent(KeyEvent e);

    /**
     * required for processing
     */
    public void dispose() {
        setActive(false);
    }
}
