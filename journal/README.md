## 11-10-2024 to 11-18-2024: ISS SSTV!
The ISS is having a special SSTV event this week on $145.800$ MHz! So, I stayed up late on the 10th building a 3-element Yagi-Uda antenna after doing some research. Last year, there was a holiday SSTV event that I built a giant corner reflector for, but that was using the cross-band repeater on $437.800$ MHz, so I couldn't use it for this event. Also, that antenna was giant, bulky, and heavy:

TODO insert image

So, I built a much lighter Yagi antenna out of a yardstick as the boom, wire hangers as the conductors, and hot glue to hold it all together. It's so much easier to hold!

TODO insert image

I decided to try simulating it in EZNEC -- it has a maximum gain of $6.93$ dB, a good deal more than a standard dipole ($2.16$ dB if I remember correctly):

![EZNEC simulation of antenna](eznec_iss_yagi0.png)

So, I left a robotics meeting to go to the top of a staircase at around 6:30pm on the 11th and point my antenna at a space station. The conflict was unfortunate, but the ISS timing would be harder to change :) I used `gpredict` to account for Doppler shift and give me the azimuth and elevation angles of the station (yaw and pitch I guess?), `gqrx` to receive the signal from my RTL-SDR dongle, and `qsstv` to decode the SSTV image. 

TODO insert image of setup

![received image yay](PD120_20241111_234751.png)

let's gooo! we got one :)

There was another pass at ~8:19pm on the 11th that I was less optimistic about (max angle: ~20 degrees, versus ~30 for the other one). I told some of my friends about my silly endeavor so was able to hear beeping (oops spoiler) along with other people:

![even better](PD120_20241112_012739.png)

And somehow this one was even better. Now time to research the theory behind how this works :) I'm not sure how my luck resulted in receiving the exact same image (out of 12) twice...such is life /shrug but I'm still really happy I got some and am excited to collect more over the course of the week! I love doing this :)