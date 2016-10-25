/*
 *   __               .__       .__  ._____.           
 * _/  |_  _______  __|__| ____ |  | |__\_ |__   ______
 * \   __\/  _ \  \/  /  |/ ___\|  | |  || __ \ /  ___/
 *  |  | (  <_> >    <|  \  \___|  |_|  || \_\ \\___ \ 
 *  |__|  \____/__/\_ \__|\___  >____/__||___  /____  >
 *                   \/       \/             \/     \/ 
 *
 * Copyright (c) 2006-2011 Karsten Schmidt
 * 
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 * 
 * http://creativecommons.org/licenses/LGPL/2.1/
 * 
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA 02110-1301, USA
 */

package toxi.math;

/**
 * Lookup table for fast sine & cosine computations. Tables with varying
 * precisions can be created to which input angles will be rounded to. The
 * sin/cos methods can be used with both positive and negative input angles as
 * with the normal Math.sin()/Math.cos() versions.
 */
public final class SinCosLUT {

    /**
     * default precision
     */
    public static final double DEFAULT_PRECISION = 0.25;

    private static SinCosLUT DEFAULT_INSTANCE;

    public static final SinCosLUT getDefaultInstance() {
        if (DEFAULT_INSTANCE == null) {
            DEFAULT_INSTANCE = new SinCosLUT();
        }
        return DEFAULT_INSTANCE;
    }

    /**
     * Lookup table for sine values
     */
    private final double[] sinLUT;

    private final double precision;

    private final int period;
    private final int quadrant;

    private final double deg2rad;
    private final double rad2deg;

    public SinCosLUT() {
        this(DEFAULT_PRECISION);
    }

    public SinCosLUT(double precision) {
        this.precision = precision;
        this.period = (int) (360 / precision);
        this.quadrant = period >> 2;
        this.deg2rad = (double) (Math.PI / 180.0) * precision;
        this.rad2deg = (double) (180.0 / Math.PI) / precision;
        this.sinLUT = new double[period];
        for (int i = 0; i < period; i++) {
            sinLUT[i] = (double) Math.sin(i * deg2rad);
        }
    }

    /**
     * Calculate cosine for the passed in angle in radians.
     * 
     * @param theta
     * @return cosine value for theta
     */
    public final double cos(double theta) {
        while (theta < 0) {
            theta += Math.PI * 2;
        }
        return sinLUT[((int) (theta * rad2deg) + quadrant) % period];
    }

    public int getPeriod() {
        return period;
    }

    public double getPrecision() {
        return precision;
    }

    public double[] getSinLUT() {
        return sinLUT;
    }

    /**
     * Calculates sine for the passed angle in radians.
     * 
     * @param theta
     * @return sine value for theta
     */
    public final double sin(double theta) {
        while (theta < 0) {
            theta += Math.PI * 2;
        }
        return sinLUT[(int) (theta * rad2deg) % period];
    }
}
