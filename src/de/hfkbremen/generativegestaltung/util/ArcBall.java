/*

Adapted into Processing library 5th Feb 2006 Tom Carden
from "simple arcball use template" 9.16.03 Simon Greenwold

Copyright (c) 2003 Simon Greenwold
Copyright (c) 2006 Tom Carden

This library is free software; you can redistribute it and/or
modify it under the terms of the GNU Lesser General Public
License as published by the Free Software Foundation; either
version 2.1 of the License, or (at your option) any later version.

This library is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General
Public License along with this library; if not, write to the
Free Software Foundation, Inc., 59 Temple Place, Suite 330,
Boston, MA  02111-1307  USA

 */


package de.hfkbremen.generativegestaltung.util;


import processing.core.PApplet;
import java.awt.event.MouseEvent;


public class ArcBall {

    PApplet parent;

    public static boolean DONT_REGISTER = false;

    public float center_x, center_y, center_z, radius;

    Vec3 v_down, v_drag;

    Quat q_now, q_down, q_drag;

    Vec3[] axisSet;

    int axis;

    /** defaults to radius of min(width/2,height/2) and center_z of -radius */
    public ArcBall(PApplet parent) {
        this(parent.g.width / 2.0f, parent.g.height / 2.0f, -PApplet.min(parent.g.width / 2.0f, parent.g.height / 2.0f), PApplet.min(parent.g.width / 2.0f, parent.g.height / 2.0f), parent);
    }

    public ArcBall(float center_x, float center_y, float center_z, float radius, PApplet parent) {

        this.parent = parent;

        parent.registerMouseEvent(this);
        if (!DONT_REGISTER) {
            parent.registerPre(this);
        }

        this.center_x = center_x;
        this.center_y = center_y;
        this.center_z = center_z;
        this.radius = radius;

        v_down = new Vec3();
        v_drag = new Vec3();

        q_now = new Quat();
        q_down = new Quat();
        q_drag = new Quat();

        axisSet = new Vec3[] {
                    new Vec3(1.0f, 0.0f, 0.0f), new Vec3(0.0f, 1.0f, 0.0f), new Vec3(0.0f, 0.0f, 1.0f)};
        axis = -1;  // no constraints...
    }

    public void mouseEvent(MouseEvent event) {
        int id = event.getID();
        if (id == MouseEvent.MOUSE_DRAGGED) {
            mouseDragged();
        } else if (id == MouseEvent.MOUSE_PRESSED) {
            mousePressed();
        }
    }

    public void mousePressed() {
        v_down = mouse_to_sphere(parent.mouseX, parent.mouseY);
        q_down.set(q_now);
        q_drag.reset();
    }

    public void mouseDragged() {
        v_drag = mouse_to_sphere(parent.mouseX, parent.mouseY);
        q_drag.set(Vec3.dot(v_down, v_drag), Vec3.cross(v_down, v_drag));
    }

    public void pre() {
        parent.translate(center_x, center_y, center_z);
        q_now = Quat.mul(q_drag, q_down);
        applyQuat2Matrix(q_now);
        parent.translate(-center_x, -center_y, -center_z);
    }

    Vec3 mouse_to_sphere(float x, float y) {
        Vec3 v = new Vec3();
        v.x = (x - center_x) / radius;
        v.y = (y - center_y) / radius;

        float mag = v.x * v.x + v.y * v.y;
        if (mag > 1.0f) {
            v.normalize();
        } else {
            v.z = PApplet.sqrt(1.0f - mag);
        }

        return (axis == -1) ? v : constrain_vector(v, axisSet[axis]);
    }

    Vec3 constrain_vector(Vec3 vector, Vec3 axis) {
        Vec3 res = new Vec3();
        res.sub(vector, Vec3.mul(axis, Vec3.dot(axis, vector)));
        res.normalize();
        return res;
    }

    void applyQuat2Matrix(Quat q) {
        // instead of transforming q into a matrix and applying it...

        float[] aa = q.getValue();
        parent.rotate(aa[0], aa[1], aa[2], aa[3]);
    }

    static class Vec3 {

        float x, y, z;

        Vec3() {
        }

        Vec3(float x, float y, float z) {
            this.x = x;
            this.y = y;
            this.z = z;
        }

        void normalize() {
            float length = length();
            x /= length;
            y /= length;
            z /= length;
        }

        float length() {
            return PApplet.mag(x, y, z);
        }

        static Vec3 cross(Vec3 v1, Vec3 v2) {
            Vec3 res = new Vec3();
            res.x = v1.y * v2.z - v1.z * v2.y;
            res.y = v1.z * v2.x - v1.x * v2.z;
            res.z = v1.x * v2.y - v1.y * v2.x;
            return res;
        }

        static float dot(Vec3 v1, Vec3 v2) {
            return v1.x * v2.x + v1.y * v2.y + v1.z * v2.z;
        }

        static Vec3 mul(Vec3 v, float d) {
            Vec3 res = new Vec3();
            res.x = v.x * d;
            res.y = v.y * d;
            res.z = v.z * d;
            return res;
        }

        void sub(Vec3 v1, Vec3 v2) {
            x = v1.x - v2.x;
            y = v1.y - v2.y;
            z = v1.z - v2.z;
        }
    } // Vec3

    static class Quat {

        float w, x, y, z;

        Quat() {
            reset();
        }

        Quat(float w, float x, float y, float z) {
            this.w = w;
            this.x = x;
            this.y = y;
            this.z = z;
        }

        void reset() {
            w = 1.0f;
            x = 0.0f;
            y = 0.0f;
            z = 0.0f;
        }

        void set(float w, Vec3 v) {
            this.w = w;
            x = v.x;
            y = v.y;
            z = v.z;
        }

        void set(Quat q) {
            w = q.w;
            x = q.x;
            y = q.y;
            z = q.z;
        }

        static Quat mul(Quat q1, Quat q2) {
            Quat res = new Quat();
            res.w = q1.w * q2.w - q1.x * q2.x - q1.y * q2.y - q1.z * q2.z;
            res.x = q1.w * q2.x + q1.x * q2.w + q1.y * q2.z - q1.z * q2.y;
            res.y = q1.w * q2.y + q1.y * q2.w + q1.z * q2.x - q1.x * q2.z;
            res.z = q1.w * q2.z + q1.z * q2.w + q1.x * q2.y - q1.y * q2.x;
            return res;
        }

        float[] getValue() {
            // transforming this quat into an angle and an axis vector...

            float[] res = new float[4];

            float sa = (float)Math.sqrt(1.0f - w * w);
            if (sa < PApplet.EPSILON) {
                sa = 1.0f;
            }

            res[0] = (float)Math.acos(w) * 2.0f;
            res[1] = x / sa;
            res[2] = y / sa;
            res[3] = z / sa;

            return res;
        }
    } // Quat
}


