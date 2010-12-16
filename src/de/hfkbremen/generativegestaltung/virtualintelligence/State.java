

package de.hfkbremen.generativegestaltung.virtualintelligence;


public interface State {

    void begin();

    void loop();

    void draw();

    void terminate();
}
