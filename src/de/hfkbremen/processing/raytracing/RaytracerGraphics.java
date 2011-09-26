/* -*- mode: java; c-basic-offset: 2; indent-tabs-mode: nil -*- */

/*
 * RawDXF - Code to write DXF files with beginRaw/endRaw
 * An extension for the Processing project - http://processing.org
 * <p/>
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * <p/>
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * <p/>
 * You should have received a copy of the GNU Lesser General
 * Public License along with the Processing project; if not,
 * write to the Free Software Foundation, Inc., 59 Temple Place,
 * Suite 330, Boston, MA  02111-1307  USA
 */

package de.hfkbremen.processing.raytracing;


import de.hfkbremen.processing.xml.XMLElement;
import java.io.File;
import java.io.FileWriter;
import java.io.IOException;
import java.io.PrintWriter;
import processing.core.PGraphics3D;


/**
 * Because this is used with beginRaw() and endRaw(), only individual
 * triangles and (discontinuous) line segments will be accepted.
 * <P/>
 * Use something like a keyPressed() in PApplet to trigger it,
 * to avoid firing off too many raytracing requests.
 * <p/>
 * Based on the 'RaxDXF' writer included in the processing 1.2 distribution, September 2010.
 */
public class RaytracerGraphics
        extends PGraphics3D {

    private File mFile;

    private XMLElement mXML;

    private static final String NEWLINE = "\n";

    private int mTriangleCount = 0;

    private XMLElement mMeshNode;

    private int mTotalVertexCount = 0;

    private static final String RENDER_NODE =
            "<background name=\"world_background\">" + NEWLINE
            + "<color r=\"1\" g=\"1\" b=\"1\" a=\"1\"/>" + NEWLINE
            + "	<power fval=\"1\"/>" + NEWLINE
            + "	<type sval=\"constant\"/>" + NEWLINE
            + "</background>" + NEWLINE
            + "" + NEWLINE
            + "<integrator name=\"default\">" + NEWLINE
            + "	<AO_color r=\"1\" g=\"1\" b=\"1\" a=\"1\"/>" + NEWLINE
            + "	<AO_distance fval=\"1\"/>" + NEWLINE
            + "	<AO_samples ival=\"32\"/>" + NEWLINE
            + "	<caustic_depth ival=\"10\"/>" + NEWLINE
            + "	<caustic_mix ival=\"100\"/>" + NEWLINE
            + "	<caustic_radius fval=\"0.25\"/>" + NEWLINE
            + "	<caustics bval=\"true\"/>" + NEWLINE
            + "	<do_AO bval=\"true\"/>" + NEWLINE
            + "	<photons ival=\"500000\"/>" + NEWLINE
            + "	<raydepth ival=\"2\"/>" + NEWLINE
            + "	<shadowDepth ival=\"2\"/>" + NEWLINE
            + "	<transpShad bval=\"false\"/>" + NEWLINE
            + "	<type sval=\"directlighting\"/>" + NEWLINE
            + "</integrator>" + NEWLINE
            + "" + NEWLINE
            + "<integrator name=\"volintegr\">" + NEWLINE
            + "	<type sval=\"none\"/>" + NEWLINE
            + "</integrator>" + NEWLINE
            + "" + NEWLINE
            + "<render>" + NEWLINE
            + "	<AA_inc_samples ival=\"1\"/>" + NEWLINE
            + "	<AA_minsamples ival=\"1\"/>" + NEWLINE
            + "	<AA_passes ival=\"1\"/>" + NEWLINE
            + "	<AA_pixelwidth fval=\"1.5\"/>" + NEWLINE
            + "	<AA_threshold fval=\"0.05\"/>" + NEWLINE
            + "	<background_name sval=\"world_background\"/>" + NEWLINE
            + "	<camera_name sval=\"cam\"/>" + NEWLINE
            + "	<clamp_rgb bval=\"false\"/>" + NEWLINE
            + "	<filter_type sval=\"box\"/>" + NEWLINE
            + "	<gamma fval=\"1.8\"/>" + NEWLINE
            + "	<height ival=\"600\"/>" + NEWLINE
            + "	<integrator_name sval=\"default\"/>" + NEWLINE
            + "	<threads ival=\"1\"/>" + NEWLINE
            + "	<volintegrator_name sval=\"volintegr\"/>" + NEWLINE
            + "	<width ival=\"800\"/>" + NEWLINE
            + "	<xstart ival=\"0\"/>" + NEWLINE
            + "	<ystart ival=\"0\"/>" + NEWLINE
            + "	<z_channel bval=\"true\"/>" + NEWLINE
            + "</render>" + NEWLINE
            + "" + NEWLINE
            + "" + NEWLINE
            + "<material name=\"defaultMat\">" + NEWLINE
            + "	<type sval=\"shinydiffusemat\"/>" + NEWLINE
            + "</material>" + NEWLINE
            + "" + NEWLINE
            + "<camera name=\"cam\">" + NEWLINE
            + "	<from x=\"0\" y=\"0\" z=\"3\"/>" + NEWLINE
            + "	<resx ival=\"800\"/>" + NEWLINE
            + "	<resy ival=\"600\"/>" + NEWLINE
            + "	<to x=\"-0.611351\" y=\"0.0702161\" z=\"-0.788238\"/>" + NEWLINE
            + "	<type sval=\"perspective\"/>" + NEWLINE
            + "	<up x=\"0.0215415\" y=\"0.997163\" z=\"0.0721198\"/>" + NEWLINE
            + "</camera>";

    public void setPath(String path) {
        this.path = path;
        if (path != null) {
            mFile = new File(path);
            if (!mFile.isAbsolute()) {
                mFile = null;
            }
        }
        if (mFile == null) {
            throw new RuntimeException(RaytracerGraphics.class.getName()
                    + " requires an absolute path "
                    + "for the location of the output file.");
        }
    }

    // ..............................................................
    protected void allocate() {
    }

    public void dispose() {
        writeFooter();
        saveXML(mFile, mXML);
    }

    public boolean displayable() {
        return false;  // just in case someone wants to use this on its own
    }

    public void beginDraw() {
        if (mXML == null) {
            mXML = new XMLElement("scene");
            mXML.setString("type", "triangle");
            writeHeader();
        }
    }

    public void endDraw() {
        System.out.println("### collected " + mTotalVertexCount + " vertices in total.");
    }

    public void beginShape(int kind) {
        shape = kind;

        if ((shape != LINES)
                && (shape != TRIANGLES)
                && (shape != POLYGON)) {
            String err =
                    RaytracerGraphics.class.getName()
                    + "can only be used with beginRaw(), "
                    + "because it only supports lines and triangles";
            throw new RuntimeException(err);
        }

        if ((shape == POLYGON) && fill) {
            throw new RuntimeException(RaytracerGraphics.class.getName()
                    + "only supports non-filled shapes.");
        }

        vertexCount = 0;
        mTriangleCount = 0;

        /* create mesh node and add it to parent */
        mMeshNode = new XMLElement();
        mXML.addChild(mMeshNode);

        /* book keeping */
        mMeshNode.setName("mesh");
        setBoolean(mMeshNode, "has_orco", false);
        setBoolean(mMeshNode, "has_uv", false);
        setInt(mMeshNode, "type", 0);

        /* material */
        final XMLElement mMaterial = new XMLElement();
        mMaterial.setName("set_material");
        setString(mMaterial, "sval", "defaultMat");
        mMeshNode.addChild(mMaterial);
    }

    public void vertex(float x, float y) {
        vertex(x, y, 0);
    }

    public void vertex(float x, float y, float z) {
        mTotalVertexCount++;

        float vertex[] = vertices[vertexCount];

        vertex[X] = x;  // note: not mx, my, mz like PGraphics3
        vertex[Y] = y;
        vertex[Z] = z;

        if (fill) {
            vertex[R] = fillR;
            vertex[G] = fillG;
            vertex[B] = fillB;
            vertex[A] = fillA;
        }

        if (stroke) {
            vertex[SR] = strokeR;
            vertex[SG] = strokeG;
            vertex[SB] = strokeB;
            vertex[SA] = strokeA;
            vertex[SW] = strokeWeight;
        }

        if (textureImage != null) {  // for the future?
            vertex[U] = textureU;
            vertex[V] = textureV;
        }

        vertexCount++;

        if ((shape == LINES) && (vertexCount == 2)) {
            writeLine(0, 1);
            vertexCount = 0;
        } else if ((shape == TRIANGLES) && (vertexCount == 3)) {
            mTriangleCount++;
            writeTriangle();
        }
    }

    public void endShape(int mode) {
        if (shape == POLYGON) {
            for (int i = 0; i < vertexCount - 1; i++) {
                writeLine(i, i + 1);
            }
            if (mode == CLOSE) {
                writeLine(vertexCount - 1, 0);
            }
        }
    }

    /* default scene */
    private void addRendererSettings(XMLElement pNode) {
        final XMLElement mRenderNode = new XMLElement(RENDER_NODE);
        pNode.addChild(mRenderNode);
    }

//    private void addDefaultMaterial(final XMLElement pNode) {
//
//        final XMLElement mMaterialNode = new XMLElement();
//        mMaterialNode.setName("material");
//        setString(mMaterialNode, "name", "defaultMat");
//
//        final XMLElement mSubNode = new XMLElement();
//        mSubNode.setName("type");
//        setString(mSubNode, "sval", "shinydiffusemat");
//        mMaterialNode.addChild(mSubNode);
//
//        pNode.addChild(mMaterialNode);
//    }
//
//    private void addDefaultBackground(final XMLElement pNode) {
//
//        final XMLElement mBackgroundNode = new XMLElement();
//        mBackgroundNode.setName("background");
//        setString(mBackgroundNode, "name", "world_background");
//
//        final XMLElement mColorNode = new XMLElement("color");
//        mColorNode.setInt("r", 1);
//        mColorNode.setInt("g", 1);
//        mColorNode.setInt("b", 1);
//        final XMLElement mPowerNode = new XMLElement("power");
//        mPowerNode.setInt("fval", 1);
//        final XMLElement mTypeNode = new XMLElement("type");
//        mTypeNode.setString("sval", "constant");
//
//        mBackgroundNode.addChild(mColorNode);
//        mBackgroundNode.addChild(mPowerNode);
//        mBackgroundNode.addChild(mTypeNode);
//
//        pNode.addChild(mBackgroundNode);
//    }
    private void writeHeader() {
        addRendererSettings(mXML);
//        addDefaultMaterial(mXML);
//        addDefaultBackground(mXML);
    }

    private void writeFooter() {
    }

    private void writeTriangle() {

//        /* create node and add it to parent */
//        final XMLElement mNode = new XMLElement();
//
//        /* book keeping */
//        mNode.setName("mesh");
//        setBoolean(mNode, "has_orco", false);
//        setBoolean(mNode, "has_uv", false);
//        setInt(mNode, "type", 0);

        setVertex(mMeshNode, vertices[0]);
        setVertex(mMeshNode, vertices[1]);
        setVertex(mMeshNode, vertices[2]);

        vertexCount = 0;

//        /* material */
//        final XMLElement mMaterial = new XMLElement();
//        mMaterial.setName("set_material");
//        setString(mMaterial, "sval", "defaultMat");
//        mNode.addChild(mMaterial);

        /* vertices */
        setInt(mMeshNode, "vertices", mTriangleCount * 3);

        /* faces */
        setInt(mMeshNode, "faces", mTriangleCount);
        final XMLElement f = new XMLElement();
        f.setName("f");
        setInt(f, "a", (mTriangleCount - 1) * 3 + 0);
        setInt(f, "b", (mTriangleCount - 1) * 3 + 1);
        setInt(f, "c", (mTriangleCount - 1) * 3 + 2);
        mMeshNode.addChild(f);

//        /* faces */
//        setInt(mNode, "faces", 1);
//        final XMLElement f = new XMLElement();
//        f.setName("f");
//        setInt(f, "a", 0);
//        setInt(f, "b", 1);
//        setInt(f, "c", 2);
//        mNode.addChild(f);

//        mXML.addChild(mNode);
    }

    private static final void setString(final XMLElement mNode,
                                        final String a,
                                        final String v) {
        mNode.setString(a, v);
    }

    private static final void setBoolean(final XMLElement mNode,
                                         final String a,
                                         final boolean v) {
        mNode.setString(a, String.valueOf(v));
    }

    private static final void setInt(final XMLElement mNode,
                                     final String a,
                                     final int v) {
        mNode.setString(a, String.valueOf(v));
    }

    private static final void setFloat(final XMLElement mNode,
                                       final String a,
                                       final float v) {
        mNode.setString(a, String.valueOf(v));
    }

    private void writeLine(int index1, int index2) {
    }

    private static void setVertex(final XMLElement mNode, float[] mVertex) {
        final XMLElement p = new XMLElement();
        p.setName("p");
        setVector3f(p, mVertex);
        mNode.addChild(p);
    }

    private static void setVector3f(final XMLElement pXMLElement, float[] p) {
        setFloat(pXMLElement, "x", p[X]);
        setFloat(pXMLElement, "y", p[Y]);
        setFloat(pXMLElement, "z", p[Z]);
    }

    /*
     * there seems to be a bit of confusion with the processing s XML package.
     * it appears to be inbetween developement steps.
     * for now we have to makedo by copying the writer to this project.
     * will change this as soon as the current SVN version is public.
     */
    private static void saveXML(final File pAbsoluteFilePath, final XMLElement pXML) {
        try {
            final PrintWriter mWriter = new PrintWriter(new FileWriter(pAbsoluteFilePath));
            pXML.write(mWriter);
            mWriter.close();
        } catch (IOException ex) {
            ex.printStackTrace();
        }
    }
}
