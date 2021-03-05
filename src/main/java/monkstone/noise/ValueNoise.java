package monkstone.noise;
import java.util.Random;
import monkstone.fastmath.DegLutTables;
import processing.core.PConstants;

public class ValueNoise implements Noise {

//////////////////////////////////////////////////////////////
// PROCESSING NOISE, rewritten by cfloutier to change the way cosinus is computed
// [toxi 040903]
// octaves and amplitude amount per octave are now user controlled
// via the noiseDetail() function.
// [toxi 030902]
// cleaned up code and now using bagel's cosine table to speed up
// [toxi 030901]
// implementation by the german demo group farbrausch
// as used in their demo "art": http://www.farb-rausch.de/fr010src.zip
    static final int PERLIN_YWRAPB = 4;
    static final int PERLIN_YWRAP = 1 << PERLIN_YWRAPB;
    static final int PERLIN_ZWRAPB = 8;
    static final int PERLIN_ZWRAP = 1 << PERLIN_ZWRAPB;
    static final int PERLIN_SIZE = 4095;

    int perlin_octaves = 4; // default to medium smooth
    float perlin_amp_falloff = 0.5f; // 50% reduction/octave
    int perlin_PI;
    static final int PERLIN_TWOPI = 65536;

    //float[] perlin_cosTable;
    float[] perlin;

    Random perlinRandom;

    @Override
    public float noise(float x) {
        return noise(x, 0f, 0f);
    }

    @Override
    public float noise(float x, float y) {
        return noise(x, y, 0f);
    }

    private float noise_fsc(float i) {
        float cosvalue = DegLutTables.cos(i * PConstants.PI);
        return 0.5f * (1.0f - cosvalue);
    }

    /**
     *
     * @param x
     * @param y
     * @param z
     * @return
     */
    @Override
    public float noise(float x, float y, float z) {
        if (perlin == null) {
            if (perlinRandom == null) {
                perlinRandom = new Random();
            }
            perlin = new float[PERLIN_SIZE + 1];
            for (int i = 0; i < PERLIN_SIZE + 1; i++) {
                perlin[i] = perlinRandom.nextFloat();
            }
        }

        if (x < 0) {
            x = -x;
        }
        if (y < 0) {
            y = -y;
        }
        if (z < 0) {
            z = -z;
        }

        int xi = (int) x, yi = (int) y, zi = (int) z;
        float xf = x - xi;
        float yf = y - yi;
        float zf = z - zi;
        float rxf, ryf;

        float r = 0;
        float ampl = 0.5f;

        float n1, n2, n3;

        for (int i = 0; i < perlin_octaves; i++) {
            int of = xi + (yi << PERLIN_YWRAPB) + (zi << PERLIN_ZWRAPB);

            rxf = noise_fsc(xf);
            ryf = noise_fsc(yf);

            n1 = perlin[of & PERLIN_SIZE];
            n1 += rxf * (perlin[(of + 1) & PERLIN_SIZE] - n1);
            n2 = perlin[(of + PERLIN_YWRAP) & PERLIN_SIZE];
            n2 += rxf * (perlin[(of + PERLIN_YWRAP + 1) & PERLIN_SIZE] - n2);
            n1 += ryf * (n2 - n1);

            of += PERLIN_ZWRAP;
            n2 = perlin[of & PERLIN_SIZE];
            n2 += rxf * (perlin[(of + 1) & PERLIN_SIZE] - n2);
            n3 = perlin[(of + PERLIN_YWRAP) & PERLIN_SIZE];
            n3 += rxf * (perlin[(of + PERLIN_YWRAP + 1) & PERLIN_SIZE] - n3);
            n2 += ryf * (n3 - n2);

            n1 += noise_fsc(zf) * (n2 - n1);

            r += n1 * ampl;
            ampl *= perlin_amp_falloff;
            xi <<= 1;
            xf *= 2;
            yi <<= 1;
            yf *= 2;
            zi <<= 1;
            zf *= 2;

            if (xf >= 1.0f) {
                xi++;
                xf--;
            }
            if (yf >= 1.0f) {
                yi++;
                yf--;
            }
            if (zf >= 1.0f) {
                zi++;
                zf--;
            }
        }
        return r;
    }
    
    @Override
    public void noiseMode(NoiseMode mode) {
        
    }

    @Override
    public void noiseDetail(int lod) {
        if (lod > 0) {
            perlin_octaves = lod;
        }
    }

    @Override
    public void noiseDetail(int lod, float falloff) {
        if (lod > 0) {
            perlin_octaves = lod;
        }
        if (falloff > 0) {
            perlin_amp_falloff = falloff;
        }
    }

    @Override
    public void noiseSeed(long seed) {
        if (perlinRandom == null) {
            perlinRandom = new Random();
        }
        perlinRandom.setSeed(seed);
        perlin = null;
    }

    @Override
    public float noise(float x, float y, float z, float w) {
        throw new UnsupportedOperationException("Not supported yet.");
    }
}