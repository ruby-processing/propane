/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package monkstone.noise;

/**
 *
 * @author Martin Prout
 */
public class NoiseGenerator implements Noise {

    private Noise implementation;
    private NoiseMode mode;

    public NoiseGenerator() {
        this.implementation = new ValueNoise();
        this.mode = NoiseMode.PERLIN;
    }

    public void noiseMode(NoiseMode mode) {
        if (this.mode != mode && this.mode != NoiseMode.PERLIN) {
            this.implementation = new ValueNoise();
            this.mode = NoiseMode.PERLIN;
        }
        if (this.mode != mode && this.mode != NoiseMode.SIMPLEX) {
            this.implementation = new SimplexNoise();
            this.mode = NoiseMode.SIMPLEX;
        }
    }

    public NoiseMode noiseMode(){
        return this.mode;
    }

    @Override
    public float noise(float x, float y, float z) {
        return implementation.noise(x, y, z);
    }

    @Override
    public float noise(float x, float y, float z, float w) {
      if (mode == NoiseMode.PERLIN) { return 0.5f;}
        return implementation.noise(x, y, z, w);
    }

    @Override
    public void noiseDetail(int lod) {
        implementation.noiseDetail(lod);
    }

    @Override
    public void noiseDetail(int lod, float falloff) {
        implementation.noiseDetail(lod, falloff);
    }

    @Override
    public void noiseSeed(long seed) {
        implementation.noiseSeed(seed);
    }

}
