package monkstone;

import java.nio.file.WatchEvent;

public interface CodeListener {
    public void code_event(WatchEvent<?> event);     
}
