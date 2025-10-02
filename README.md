# Homepage

This repository contains the files used to exposes an website using docker compose in a constant port.

### Intent

I have at home a tablet with a raspberry pi 3 at the background.

I installed a [FullPageOs](https://github.com/guysoft/FullPageOS)) on the raspberry that shows a given webpage.

Just after booting, it will mount a docker that exposes at a given port the Homepage with calendar etc.

To make it easier to modify the Homepage style, I intent to make the raspberry pi pull this repository and update the docker image before mounting it. 
So if I want to change docker, I make the change on the repository and I sent the signal to the raspberry pi to reboot.