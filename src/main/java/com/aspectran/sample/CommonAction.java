package com.aspectran.sample;

public class CommonAction {

    public void delay(int seconds) throws InterruptedException {
        Thread.sleep(seconds * 1000);
    }

}
