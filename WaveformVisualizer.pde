/**
* An fft visualizer using bars
*/
import processing.sound.*;

// for soundcard input
AudioIn in;
FFT fft;
int bands = 64;
float[] spectrum = new float[bands];
float bandSize;

void setup() {
    size(1024, 256);
    // get soundcard input
    in = new AudioIn(this, 0);

    // create new fft
    fft = new FFT(this);

    // start audio input
    in.start();

    // attach fft to audio input
    fft.input(in);
    noStroke();
    bandSize = width / (2*bands);
}

void draw() {
    background(255);
    color violet = #2300D4;
    color orange = #F7BB0A;

    // analyze spectrum of audio input using fft
    fft.analyze(spectrum);

    // loop over each band
    for(int i = 0; i < bands; i++){
        // get percentage of how much we've done so far
        float p = i / (float) bands;
        // interpolate color to find correct color based on our current band
        color c = lerpColor(violet, orange, p);
        fill(c);

        // draw a rect representing frequency with amplitude of spectrum[i]*height*5
        rect(i*(bandSize+10), height/2, bandSize, -spectrum[i]*height*5);
    } 
    save("freq.png");
}
