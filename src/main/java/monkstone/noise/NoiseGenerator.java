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
public class NoiseGenerator implements Noise{
    
    private final Noise implementation;
    
    public NoiseGenerator(){
        this.implementation = new ValueNoise();
           
    }
    
    public NoiseGenerator(Noise implementation){
        this.implementation = implementation;
       }
    
    @Override
    public float noise(float x, float y, float z) {
        return implementation.noise(x, y, z);
    }
    
        @Override
    public float noise(float x, float y, float z, float w) {
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
