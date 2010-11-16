

package de.hfkbremen.generativegestaltung.implicitsurface.marchingcubes;


import processing.core.PVector;


public class Metaball {

    public PVector position;

    public float strength;

    public float radius;

    public Metaball(PVector thePosition, float theStrength, float theRadius) {
        position = thePosition.get();
        strength = theStrength;
        radius = theRadius;
    }
}
