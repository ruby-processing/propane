package monkstone.noise;

/*
 * Copyright (c) 2021 Martin Prout
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU General Public
 * License as published by the Free Software Foundation; either
 * version 3.0 of the License, or (at your option) any later version.
 *
 * http://creativecommons.org/licenses/LGPL/2.1/
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
 * Lesser General Public License for more details.
 *
 * You should have received a copy of the GNU General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */
public interface Noise {

    /**
     *
     * @param x
     * @return
     */
    default float noise(float x) {
        return noise(x, 0);
    }

    /**
     *
     * @param x
     * @param y
     * @return
     */
    default float noise(float x, float y) {
        return noise(x, y, 0);
    }

    /**
     * <p>
     * Returns the Perlin noise value at specified coordinates. Perlin noise is
     * a random sequence generator producing a more natural ordered, harmonic
     * succession of numbers compared to the standard <b>random()</b> function.
     * It was invented by Ken Perlin in the 1980s and been used since in
     * graphical applications to produce procedural textures, natural motion,
     * shapes, terrains etc. The main difference to the
     * <b>random()</b> function is that Perlin noise is defined in an infinite
     * n-dimensional space where each pair of coordinates corresponds to a fixed
     * semi-random value (fixed only for the lifespan of the program). The
     * resulting value will always be between 0.0 and 1.0. Processing can
     * compute 1D, 2D and 3D noise, depending on the number of coordinates
     * given. The noise value can be animated by moving through the noise space
     * as demonstrated in the example above. The 2nd and 3rd dimension can also
     * be interpreted as time.The actual noise is structured similar to an audio
     * signal, in respect to the function's use of frequencies. Similar to the
     * concept of harmonics in physics, perlin noise is computed over several
     * octaves which are added together for the final result. Another way to
     * adjust the character of the resulting sequence is the scale of the input
     * coordinates. As the function works within an infinite space the value of
     * the coordinates doesn't matter as such, only the distance between
     * successive coordinates does (eg. when using <b>noise()</b> within a
     * loop). As a general rule the smaller the difference between coordinates,
     * the smoother the resulting noise sequence will be. Steps of 0.005-0.03
     * work best for most applications, but this will differ depending on use.
     * <p>
     * @param x x-coordinate in noise space
     * @param y y-coordinate in noise space
     * @param z z-coordinate in noise space
     * @return
     */
    float noise(float x, float y, float z);

    float noise(float x, float y, float z, float w);

    void noiseMode(NoiseMode mode);

    /**
     * Adjusts the character and level of detail produced by the Perlin noise
     * function.Similar to harmonics in physics, noise is computed over several
     * octaves. Lower octaves contribute more to the output signal and as such
     * define the overal intensity of the noise, whereas higher octaves create
     * finer grained details in the noise sequence. By default, noise is
     * computed over 4 octaves with each octave contributing exactly half than
     * its predecessor, starting at 50% strength for the 1st octave. This
     * falloff amount can be changed by adding an additional function parameter.
     * Eg. a falloff factor of 0.75 means each octave will now have 75% impact
     * (25% less) of the previous lower octave. Any value between 0.0 and 1.0 is
     * valid, however note that values greater than 0.5 might result in greater
     * than 1.0 values returned by <b>noise()</b>.By changing these parameters,
     * the signal created by the <b>noise()</b>
     * function can be adapted to fit very specific needs and characteristics.
     *
     * @param lod
     */
    void noiseDetail(int lod);

    /**
     * @param lod
     * @param falloff falloff factor for each octave
     */
    void noiseDetail(int lod, float falloff);

    /**
     * Sets the seed value for <b>noise()</b>.By default, <b>noise()</b>
     * produces different results each time the program is run. Set the
     * <b>value</b> parameter to a constant to return the same pseudo-random
     * numbers each time the software is run.
     *
     * @param seed
     */
    void noiseSeed(long seed);
}
