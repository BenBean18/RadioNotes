## 11-10-2024 to 11-18-2024: ISS SSTV!
### 11-10-2024
The ISS is having a special SSTV event this week on $145.800$ MHz! So, I stayed up late on the 10th building a 3-element Yagi-Uda antenna after doing some research. Last year, there was a holiday SSTV event that I built a giant corner reflector for, but that was using the cross-band repeater on $437.800$ MHz, so I couldn't use it for this event. Also, that antenna was giant, bulky, and heavy:

TODO insert image

So, I built a much lighter Yagi antenna out of a yardstick as the boom, wire hangers as the conductors, and hot glue to hold it all together. It's so much easier to hold!

TODO insert image

I decided to try simulating it in EZNEC -- it has a maximum gain of $6.93$ dB, a good deal more than a standard dipole ($2.16$ dB if I remember correctly):

![EZNEC simulation of antenna](eznec_iss_yagi0.png)

### 11-11-2024
So, I left a robotics meeting to go to the top of a staircase at around 6:30pm on the 11th and point my antenna at a space station. The conflict was unfortunate, but the ISS timing would be harder to change :) I used `gpredict` to account for Doppler shift and give me the azimuth and elevation angles of the station (yaw and pitch I guess?), `gqrx` to receive the signal from my RTL-SDR dongle, and `qsstv` to decode the SSTV image. 

TODO insert image of setup

![received image yay](PD120_20241111_234751.png)

let's gooo! we got one :)

There was another pass at ~8:19pm on the 11th that I was less optimistic about (max angle: ~20 degrees, versus ~30 for the other one). I told some of my friends about my silly endeavor so was able to hear beeping (oops spoiler) along with other people:

![even better](PD120_20241112_012739.png)

And somehow this one was even better. Now time to research the theory behind how this works :) I'm not sure how my luck resulted in receiving the exact same image (out of 12) twice...such is life /shrug but I'm still really happy I got some and am excited to collect more over the course of the week! I love doing this :)

### 11-12-2024
Today was a pretty good day!

#### Pass #1

The first pass started at 5:53pm. I had an ultimate frisbee practice prior to this and got back on campus at 5:40pm, so I ran up four flights of stairs to my room to grab my antenna, ran back down, and went up three flights to the staircase I'm using as a high place. There are two different staircases on the same building on campus that are great for this purpose; one is **north-facing** (this one faces the main street on campus) with the building to the south, and the other is **south-facing** with the building to the north. Because most of these ISS passes are low on the horizon and the whole purpose of going up on a staircase is to get line-of-sight to it, I have to check each pass's azimuth to know whether to choose the north-facing or south-facing staircase. This pass was a south-facing pass (AOS at 195 deg SSW, peaking at 129 deg SE, LOS at 64 deg ENE), so I chose the south-facing staircase.

I started hearing a signal at 5:53:59pm, as the ISS's transmitter had just finished its initialization sequence. Great timing :) However, as I tracked the station using the compass on my phone, it just wasn't correct; I had to point my antenna in a different direction to try to get a better signal (sweeping it around after having a weak signal to find a stronger one). I then started to notice that my phone and watch compasses were **both returning incorrect values** (watch below, this should read ~90 degrees):

![A picture of an Apple Watch screen reading 46 degrees](compass_bad.png)

My image wasn't terrible, but it was definitely not ideal:
![ISS image, #3/12](PD120_20241112_225606.png)

Luckily, I still had a few minutes before LOS, and knew another SSTV image would be coming in. I decided to mostly ignore my compass's advice and just remember that south was forward, east was left, and west was right from the direction I was standing. This worked out somewhat better, but I still didn't really know where to point; I just knew which direction the ISS was going (right) and that I should slowly move my antenna that way once my signal started getting weaker. However, at around 5:59, I saw a small white dot just to the left of a big tree, moving left very near to where I was pointing my antenna. IT'S THE ISS!!!!! Needless to say, tracking was trivial for the rest of the pass :) It was amazing to actually see the object I was receiving radio waves from; without that, I was kind of dissociated from the actual antenna I was receiving waves from. Oh, and here's the image -- you can probably tell the point when I saw the ISS and the image got clearer:

![ISS image, #4/12](PD120_20241112_230015.png)

#### Pass #2

The second pass started at 7:29pm, and was north-facing. This meant I was facing a more central point of campus, and as I was setting up, I got accusatorily asked "you doing anything specific up there?" by an adult on campus. I excitedly replied I was receiving images from the ISS and got told to be careful :) The pass started pretty far left (246 deg WSW), and the ISS was actively transmitting an image, so I got part of it:

![ISS image, #2/12](PD120_20241113_003306.png)

AND I SAW THE ISS AGAIN AND WAS ABLE TO POINT MY ANTENNA AT IT FOR A BIT!!

![The ISS is visible :)](iss_visible.jpg)
I'm 99% sure the tiny white dot inside the red circle is the ISS (proof by "trust me bro"). I definitely saw it, but the picture didn't come out great because of all the ambient lighting.

And then it disappeared behind a tree :( But I heard the initial sequence of beeps for the next image and pointed my antenna towards them (moved it and if it got quieter/more static-filled then I moved back), got a lock on a clear signal, and right when I heard the faintest hint of static I moved the antenna more to the right to follow the ISS. I mostly ignored my compass. And I got my best image so far!

![ISS image, #3/12](PD120_20241113_003550.png)
This was a slightly weird feeling, because I was hearing a very clear signal (24.9 dB above the noise floor! -38.1 dBFS vs -63 dBFS noise floor) and had no clue where the ISS actually was, but I was just blindly pointing my antenna towards a signal.

Then it eventually emerged out of the right side of a big tree, but I couldn't really find it among the brighter objects in the sky and with the light pollution that pervaded the place I was standing. However, what was cool about the next image (yes I got three, let's gooooo) was that I could tell when LOS hit. The image was still being transmitted as LOS approached, and I had a very faint signal (the ISS was low on the horizon and being blocked by objects). I heard it very faintly as `gpredict`'s timer approached "LOS in 00:00", and then it just stopped (or maybe that's just the placebo effect of making up a very faint signal, but I think it was real :)). That was cool. Oh, and here's the image:

![ISS image, #4/12](PD120_20241113_003959.png)

Overall, a really great radio day! 5 images is not too bad :)