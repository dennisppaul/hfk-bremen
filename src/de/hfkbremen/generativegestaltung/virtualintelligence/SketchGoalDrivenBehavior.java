

package de.hfkbremen.generativegestaltung.virtualintelligence;


public class SketchGoalDrivenBehavior {

    interface State {

        void begin();

        void loop();

        void terminate();
    }
}
