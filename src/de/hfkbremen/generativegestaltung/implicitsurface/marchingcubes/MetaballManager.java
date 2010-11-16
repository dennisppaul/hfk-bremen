

package de.hfkbremen.generativegestaltung.implicitsurface.marchingcubes;


import java.util.Vector;
import processing.core.PVector;


public class MetaballManager {

    private Vector<Metaball> mMetaballs = new Vector<Metaball>();

    private float mThreshold;

    private PVector mGridSize;

    private float[][][] mGridValues;

    private Vector<PVector> mTriangles;

    private PVector mScale;

    private PVector mTranslate;

    public MetaballManager(float pThreshold, PVector pGridSize) {
        mThreshold = pThreshold;
        mGridSize = pGridSize.get();
    }

    public MetaballManager() {
        mThreshold = 0.1f;
        mGridSize = new PVector(10, 10, 10);
        mScale = new PVector(1, 1, 1);
        mTranslate = new PVector(0, 0, 0);
        mTriangles = new Vector<PVector>();
    }

    public void update() {
        updateGridValues();
        mTriangles.clear();
        MarchingCubes.triangles(mTriangles, mGridValues, mThreshold);
        /* transform triangels back into manager space  */
        // TODO transform matrix?
        for (int i = 0; i < mTriangles.size(); i++) {
            final PVector mPosition = mTriangles.get(i);
            mPosition.mult(mScale);
            mPosition.add(mTranslate);
        }
    }

    private void updateGridValues() {
        mGridValues = new float[(int)mGridSize.x][(int)mGridSize.y][(int)mGridSize.z];
        for (int x = 0; x < mGridValues.length; x++) {
            for (int y = 0; y < mGridValues[x].length; y++) {
                for (int z = 0; z < mGridValues[x][y].length; z++) {
                    final PVector mPosition = new PVector(x, y, z);
                    mPosition.mult(mScale);
                    mPosition.div(mGridSize);  /* normalize XYZ values */
                    mPosition.add(mTranslate);
                    mGridValues[x][y][z] = getForceFieldValue(mPosition);
                }
            }
        }
    }

    private float getForceFieldValue(PVector thePosition) {
        float f = 0;
        for (final Metaball myMetaball : mMetaballs) {
            float myDistanceSquared = myMetaball.position.dist(thePosition.get());
            myDistanceSquared *= myDistanceSquared;
            float myRadiusSquared = myMetaball.radius * myMetaball.radius;
            if (myDistanceSquared < myRadiusSquared) {
                float fallOff = 1f - (myDistanceSquared / myRadiusSquared);
                f += fallOff * fallOff * myMetaball.strength;
            }
        }
        return f;
    }

    public Vector<Metaball> metaballs() {
        return mMetaballs;
    }

    public Vector<PVector> triangles() {
        return mTriangles;
    }

    public void add(Metaball myMetaball) {
        mMetaballs.add(myMetaball);
    }

    public void remove(Metaball myMetaball) {
        mMetaballs.remove(myMetaball);
    }

    public void threshold(float threshold) {
        mThreshold = threshold;
    }

    public float threshold() {
        return mThreshold;
    }

    public PVector gridsize() {
        return mGridSize;
    }

    public PVector scale() {
        return mScale;
    }

    public PVector translate() {
        return mTranslate;
    }
}
