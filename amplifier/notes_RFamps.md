# Notes from this [amazing source](https://ludens.cl/Electron/RFamps/RFamps.html)

(I'm bored on a plane, am alive, and learning things seems like a good idea in the time I have, no internet connection but whatever)

"if you are really interested in the matter, you will need to work through it step by step"

## Amplifier types
- Class A: active device conducts current for the entire waveform (360deg), I believe the reason this is inefficient is because the active device is active all the time so losses are always present?
    - Theoretical maximum efficiency: 50% (why?)
- Class AB: in between
    - Theoretical maximum: 78.5%
- Class B: conducts current for exactly 1/2 of waveform (180deg)
- Class C: <1/2

Smaller conduction angle = higher efficiency but lower output power

So, why is Class A efficiency 50%? I found another article about common emitter amplifiers and Class A amplifiers, let's see: https://www.n5dux.com/ham/files/pdf/NorCal%2040A%20-%20PPTs/322Lecture18.pdf

This mentions one type of common emitter amplifier where the switching element Q always remains in the active region. I think this is the same as the definition of Class A.

What's the active region? Checking RD16HHF1 datasheet rn:

Well now I feel a bit silly but sure, I'll read a tutorial on transistors https://learn.sparkfun.com/tutorials/transistors/operation-modes

**The four transistor operation modes are:**
- Saturation -- The transistor acts like a short circuit. Current freely flows from collector to emitter. $V_E < V_B$, $V_C < V_B$
- Cut-off -- The transistor acts like an open circuit. No current flows from collector to emitter. $V_E > V_B$, $V_C > V_B$
- Active -- The current from collector to emitter is proportional to the base current. $V_C > V_B > V_E$
- Reverse-Active -- Like active mode, the current is proportional to the base current, but it flows in reverse. Current flows from emitter to collector (not, exactly, the purpose transistors were designed for). $V_C < V_B < V_E$

![](./mode-quadrants.png)

So what does this mean? I think forward active is the normal mode I'm used to seeing transistors in, the base acts as the switch to turn on or off current flow from collector to emitter (so the collector's voltage is higher than the emitter's voltage). However, "turn on or off" sounds just like operating in saturation or cutoff depending if there's voltage at the base or not? Maybe?

Never mind, it's definitely not, and that's weird, in saturation mode the base voltage is higher than the collector and emitter voltages and in cutoff the base voltage is lower than both. I've never actually taken the time to research these modes of operation before but seen them mentioned a lot. And I guess reverse active is just the inverse of active.

Also, PNP is backwards of this. I assume these apply to MOSFETs also? Never mind, they don't according to Google, because MOSFETs are **voltage-controlled** not current-controlled , and their modes are just cutoff, linear, and saturation. So that's basically the same but no reverse maybe?

### Saturation
on mode of a transistor, effectively a short between B and E, imagining a BJT transistor as two diodes is somewhat theoretically accurate (--N-- C<-B --P-- B->E --N-- )

![source: wikipedia](./Transistor_diode_model.png)

why are transistors asymmetric? why can't we swap C and E? apparently they are doped with different concentrations, should learn more of the materials science behind BJTs /shrug

I somewhat understand FETs now though!

Oh wait that actually makes sense! To get current to flow freely through here you have B >= C+0.7 and B >= E+0.7

Ok cool, so now what? How is saturation mode useful? (and in my application, $\overline{V_B > V_C}$)

Also, transistors aren't ideal, there's a voltage drop between E and C, so $V_E > V_C + 0.2$ or so

### Cutoff
Cutoff mode is the opposite, current isn't allowed to flow through either diode because the base voltage is less than either of the ends (although $V_{BE}$ can be up to 0.7V), womp womp, so the transistor is an open

### Active

The condition for this is $V_C > V_B > V_E$, i.e. $V_{BC} < 0$ and $V_{BE} > 0$

$V_{BE} > 0.7 V$ again, or whatever $V_{th}, V_{\gamma}, V_d$ is

Why does this conduct? 

"Base current enters the base region, and the charges flowing across the base-emitter junction do their best to annihilate the base-entering charges. Fortunately MOST of the charges provided by the emitter end up NOT INTERSECTING with the base-entering charges, instead being gathered up in the collector region. The ratio of miss-hit is the BETA."
from https://electronics.stackexchange.com/a/416819

![source: https://electronics.stackexchange.com/a/416820](./9m7cS.png)

ok so I kinda get it maybe? when charge carriers (holes) are injected into the base, charge carriers from the emitter (electrons) are attracted to the holes and try to neutralize them, but they end up missing and flowing towards the collector region instead? why is it permissible for this to happen across the reverse biased junction though

what does a reverse bias even mean? why does a diode diode?

aaaaaaaaaaaaaaaaaa

i would usually just move on here, but now i'm curious and i think actually beginning to understand fundamentals will REALLY help. time to change my MAC address to get 15 more minutes of free plane wifi.

### Diodes

Remember: threshold voltage exists (this is just a "it works this way", not how)
![source: https://commons.wikimedia.org/wiki/File:Siirded_forward_diode-characteristics.svg](./Siirded_forward_diode-characteristics.svg.png)

#### p-n junctions
n-side: has electrons, p-side has electron holes

#### depletion region
near boundary of p-n junction, and "is an insulating region within a conductive, doped semiconductor material where the mobile charge carriers dissipate, or been forced away by an electric field" (wikipedia)

![source: https://commons.wikimedia.org/wiki/File:Semiconductor_band_structure_(lots_of_bands_2).svg](./Semiconductor_band_structure_(lots_of_bands_2).svg.png)

wheeeee a mat chem jumpscare!

ok so n-type has more electrons which are in theeeeeee conduction band (filled) and p-type has more holes which are in the valence band (empty)

so now at the junction, electrons from n-type conduction band migrate to holes in p-type valence band and vice versa

and they just annihilate each other through [recombination](https://en.wikipedia.org/wiki/Recombination_(physics))

"The net result is that the diffused electrons and holes are gone." poof!

OK so the majority charge carriers ($e^-$ in n-type and holes in p-type) are depleted near the center (both from moving to the other side and from being recombined), which is what the depletion zone is!

![source: https://commons.wikimedia.org/wiki/File:Pn-junction-equilibrium-graphs.png](./1024px-Pn-junction-equilibrium-graphs.png)

N-side is positively charged? does this make sense? yes, because electrons are missing, but counterintuitive at first glance. P-side is negatively charged for the same reason.

And once the electric field there gets strong enough, diffusion stops

Threshold voltage is the integral of the electric field across the depletion region, E&M should be very interesting

Forward biasing: narrows depletion region by applying voltage in opposition to the field, i.e. positive on P-side and negative on N-side

Reverse biasing is the opposite

ok I like kinda understand that? will definitely need to review it later

and a diode is just a p-n junction, so we can go back to transistors now

### Active mode again

Ok so that explanation was a pretty good one I guess? It somewhat makes sense anyway, when holes are flowing into the base negative charge carriers/electrons come from the emitter side of the base-emitter junction to go neutralize them, but they don't all hit holes (why?) and continue until they get to the collector side of the base-collector junction, where they are majority charge carriers anyway

Why don't electrons flow from the collector to the emitter? What prevents this process from going in reverse? I already wondered this earlier, but idk which side would have a higher doping concentration. We want electrons to flow from E to C, soo... maybe collector is doped less so that more electrons are available at the emitter to go neutralize the holes at the base, miss, and continue to the collector? then it's not an equilibrium?

HA let's go that's right (emitter much more heavily doped than collector) and I'm glad I took the time to think about it...let's see if my reasoning is correct

Yes partially: "The most common design goal for the emitter, is to make it efficient at transferring its majority carriers to the base (where they become minority carriers). The most common design goal for the collector is that the maximum $V_{CE}$ of the transistor is sufficient for practical applications. These two different design goals lead to the use of different doping concentrations in the emitter and in the collector." (https://electronics.stackexchange.com/a/643964)

yay! so maybe i can reason about things sometimes if i take the time to do it

so why again can the electrons make it through to the collector? https://electronics.stackexchange.com/a/278803 says two reasons: a thin base and less doping in the base

I'm sure I'm missing so much, but now I think I mostly understand how the active mode of a BJT works.

A current of holes is injected into the base (enough to overcome the 0.7V threshold of the silicon p-n junction). If this were just the bottom diode, then they help overcome the field in the depletion region and current can travel, yay! The same thing happens here, electrons are traveling from emitter/N-type to base/P-type, but now there's another N-type section on top where the electrons can sometimes make it to and they will because the base can't catch them all, so as you inject more current into the base of a BJT more electrons are attracted from the emitter and more electrons make it to the collector

So, BJTs provide linear current gain when in active mode, $I_C = \beta I_B$

#### BJT biasing?

So why do we need to bias a BJT? One obvious reason I can think of is to get above the 0.7V threshold, but I'm always hearing it's to choose what operating mode the BJT is in. And this makes sense for saturation anyway, base has to be higher than C and E and for cutoff base has to be lower than C and E, this either forward or reverse biases both p-n junctions.

Let's check the 2N3904 datasheet. $V_{CE(sat)} = 0.3V$ and $V_{BE(sat)} = 0.95V$ at maximum. So that means the base has to be at least this much above both for the transistor to enter saturation.

wait but where's $V_{BC}$, that's the other junction

If we want the transistor to act as a switch, I guess it should switch between saturation and cutoff? But apparently cutoff is also when there's no base current, which makes sense, nothing is happening

woahhhh wikipedia rabbit hole but this is SO smart https://en.wikipedia.org/wiki/Bandgap_voltage_reference

"For bipolar junction transistors (BJTs), the operating point is defined as the steady-state DC collector-emitter voltage $\displaystyle V_{\mathrm {ce} }$ and the collector current ${\displaystyle I_{\mathrm {c} }}$ with no input signal applied." (wikipedia)

why? warum?

Ok I think I might understand it now. Maybe. For saturation mode anyway. If we look at the datasheet, we see this chart:
![2N3904 Figure 16: collector saturation region](image-22.png)

~~This means that if we want to switch idk 100 mA, we need a base current of at least 3 mA? that doesn't make sense... because $V_{CE}$ is the **minimum** voltage needed for it to be in saturation, so like if we try 100 mA with a base current of only 2 mA it will be in cutoff. However, if we want to switch 100 mA with 5 mA, that's fine!~~

^ this is wrong, see below, the chart is for $V_{CE}$ when in **saturation** which would be zero if the transistor was perfect

Biasing for active mode: we only care about current.

This looks like a really good writeup: https://electronics.stackexchange.com/questions/663662/npn-bjt-linear-region-operation, reading over it right now

Remember: $V_{CE} = 0$ when the transistor is conducting fully, except it can't be zero because transistors aren't ideal.

Hypothetical: want to switch 30 mA, $\text{V}_{\text{cc}} = 12\text{V}$, $\text{V}_\text{be} = \text{0.7V}$, $\text{I}_\text{b} = 4 \text{mA}$
(this is a beta of less than 10, gain-bandwidth product is 300 MHz / 28 MHz = 10.7)

Need to solve for $R_c$ and $R_b$

On that chart, for the curve where $I_c = 30 mA$, $V_{ce} = 0.1V$ when $I_b = 4 mA$

So what does this tell us now?

$R_b = V_{be} / I_b = 3.3V / 4 mA = 825 \Omega$

$R_c = (V_{cc} - V_{be}) / I_c = 11.3 V / 100 mA = 376 \Omega$

LTspice time, but going to push first

oops i did it wrong, will look more later

"Try to think of a BJT as a bad delivery service: you are in base and ask for a carrier; the emitter ships one to you but it gets snatched by the evil collector. You are still waiting for your carrier, so the emitter ships another one, and this one too is snatched by the collector. Out of 100 carriers, only one makes it to your contact in base. But in order to get that one carrier you have to ask for it, by means of the base current. Stop the base current and the emitter will stop the deliveries." is a good explanation: https://electronics.stackexchange.com/a/654231

https://positivefb.com/2021/06/19/bjt-amplifier-concept-to-components/

### works? in sim? even when you change the transistor?
some notes before i forget:
- capacitors between each stage are for AC coupling, they let the AC signal through but not the DC offset, and then the voltage divider after is to set the DC offset to correctly bias the transistor. i *think* they might help provide charge faster also? idk though
- emitter degeneration...honestly don't completely understand why it helps with stability yet but played around with resistor values until i found ones that worked...once i have more mental energy https://www.electronics-tutorials.com/amplifiers/emitter-degeneration.htm
- and that's about it! these are all standard component values too
![works?](image-23.png)

- 33ohm: https://www.mouser.com/ProductDetail/Susumu/HRG3216Q-33R0-D-T1?qs=Pccw3SRxl2QVimWmCTvNQQ%3D%3D

Another important takeaway: this is more efficient (I think) because I'm not actually building a linear amplifier here, this is amplifying a square wave so switching the transistor between cutoff (<0.7V) and saturation (>0.7V)

Building this:
![yay](image-24.png)

IRL: RD16HHF1 doesn't heat up at all when transmitting :( and no signal received. With the RD16HHF1 attached, voltage at its gate was like 0 instead of the intended bias of ~6.6V. So, I detached the RD16HHF1 and bias voltages were all correct to ~1.5V. So what's happening? I noticed my multimeter has a Hz measurement option, so I tried some different freqs (up to ~3M before multimeter just stopped measuring frequency) and they were mirrored at input and output! But that's not 28MHz, that's easier, so time to break out my SDR and use it as a spectrum analyzer. Results:
- 5MHz: -58 dBFS without battery attached, -47 dBFS with battery attached
- 28MHz: -46 dBFS without battery attached, -30 dBFS with battery attached

That looks good! What's the expected gain? 900 mW out with 20 mW in is a ratio of 45 which is 16.53 dB which at 28MHz is exactly what we got. so wtf is the problem?

(this makes sense too, about 10x current gain 8mA to 80mA and 4x voltage gain 3.3V to 12V)

-46 to -30

sooooo uh resistance between gate and source of the MOSFET is measured to be zero ohms. that's extremely suspicious: [gate oxide breakdown](https://www.sciencedirect.com/science/article/abs/pii/S0026271407000728)

pretty sure the RD16HHF1 is broken, going to take inside and measure another one to confirm

replaced the transistor with a theoretically working one (although slightly suspect solder joints), and nobody heard me on PSKReporter even though there were people listening on 10m in FM06 and people who heard other people on 10m in FM06. commands used (example):
`pinctrl set 17 op dl && sudo ./ft8 28074000 -a 0 "CQ KQ4TVW FM06" && pinctrl set 17 op dh && pinctrl set 17 op dl && sudo ./ft8 28074000 -a 220 "CQ KQ4TVW FM06" && pinctrl set 17 op dh`

concerningly, my transmission did show up on harmonics as well, but may have just overloaded my SDR? not sure. i'm guessing that's what happened. it was much weaker than I thought it would be though, like -20 dB with LNA and using a tiny wire as an antenna, I expected it would be strong enough to potentially hurt the SDR.

found a bad solder joint on a capacitor in series with the signal, reflowed it, still doesn't work :'(

Potential causes:
- Ground planes of two boards only attached in one place (through battery...this is an extremely long way for current to travel. maybe attaching the ground planes with a short wire is enough??)
- Many solder joints look suspicious, but read zero ohms anyway (esp. caps...the RD16HHF1 also)
- The new transistor also is broken (unlikely, gate and source have very high resistance between them)
- An inductor broke (unlikely probably since they're just wires?)
- A capacitor broke
- ~~I believe the preamp I built today works (see earlier in this document when I was using my SDR), so it's probably not that, but would need an oscilloscope to confirm. I did confirm that all the nodes I could measure were biased correctly afaict though.~~
- ~~Antenna bad? I don't think so since I was able to receive signals from Chile this morning~~

I guess the best course of action is probably to go reflow everything and see if that fixes it, but I don't want to do that right now :(

- Replace RD16HHF1 connection (did this by using the other TO220 slot (for the unused 7805) and some ugly hacks...)
- C1: replace with 120p (done)
- C2: replace with identical 100p (done)
- L2_a1: replace with identical 1.5uH (did this now)
- CS1: replace with identical 200p (did this now)
- CF1: fix GND connection (did this)

so uh idk if it's me or not, because propagation is crap tonight. :(

-50 w/ no power at all, -43 w/ no power to big amp, -30 with (but also this is the only path that exits via an antenna)

Tried replacing 47k to ground on the RD16HHF1 input with a 68k, and transistor seemed to get less warm weirdly, should have been hotter i think since longer time on?

i think i need a scope to see the output voltage of the preamp and the drain voltage of the MOSFET and get a 50ohm resistor and put it across the output and see how much voltage drop etc etc all requiring a scope :(

https://www.mouser.com/datasheet/2/115/DIOD_S_A0004873079_1-2542624.pdf

https://www.mouser.com/c/semiconductors/discrete-semiconductors/transistors/mosfets/?id%20-%20continuous%20drain%20current=200%20mA~~100%20A&mounting%20style=SMD%2FSMT&product%20type=GaN%20FETs%7C~JFETs~~MOSFETs%7C~RF%20JFET%20Transistors~~RF%20MOSFETs&qg%20-%20gate%20charge=900%20pC~~12%20nC&technology=Si&transistor%20polarity=N-Channel&vds%20-%20drain-source%20breakdown%20voltage=20%20V~~300%20V&vgs%20th%20-%20gate-source%20threshold%20voltage=0%20V~~1.2%20V&rp=semiconductors%2Fdiscrete-semiconductors%7C~Product%20Type~~semiconductors%2Fdiscrete-semiconductors%2Ftransistors%2Fmosfets%7C~Vgs%20th%20-%20Gate-Source%20Threshold%20Voltage%7C~Id%20-%20Continuous%20Drain%20Current%7C~Qg%20-%20Gate%20Charge%7C~Vds%20-%20Drain-Source%20Breakdown%20Voltage

https://assets.nexperia.com/documents/data-sheet/2N7002NXBK.pdf looks good

wait this looks awesome https://www.mouser.com/datasheet/2/196/Infineon_IRLML2060_DataSheet_v01_01_EN-3363619.pdf

https://positivefb.com/2021/06/19/bjt-amplifier-concept-to-components/

https://101-things.readthedocs.io/en/latest/ham_transmitter.html

https://101-things.readthedocs.io/en/latest/radio_receiver.html

I will have access to https://www.keysight.com/us/en/product/EDUX1052A/oscilloscope-50-mhz-2-analog-channels.html in about 20 days

2.4V - 17.4V at 10MHz, looks like a decent square wave

First 2N3904 biased to 1.28V. -240mV to 2.16V on base at 28.074MHz

Collector of first 2N3904: 5.12V - 10.2V at 28.074MHz

At 2.8 MHz, base is -1.1V to 2.1V and collector is 2.8V - 9.8V

At 10MHz, base is -1V to 2.1V and collector is 3.2V - 10.2V, still very clean

At 15MHz, starts getting clipped: base is -0.76V to 2.12V and collector is 2.88V to 10.3V, looks less like a square and not being driven low as strongly. Rise time: 15ns, fall time: 20ns. Image has 15MHz written on it.

18MHz: collector is 4V - 10.2V

20MHz: collector is 4.4V - 10.2V

28MHz: base is -0.3V - 2.1V, collector is 5.6V - 10.2V.

The base of the second stage 2N3904 is -2.4V to 2.5V, with collector going from 4.8V to 10.6V. not nearly enough swing to drive the RD16HHF1 :(

All below here has second stage disconnected

At 28.074MHz with second stage disconnected, the collector of the first 2N3904 is going from ~3.3V to 12.4V. It's basically a triangle though, not much of a square wave. Base is going from -0.24V to 2V (0-2.2V if lowest is at DC, so 1.1V dropped across a 330 ohm resistor, so 3.3mA in and (13.3 Vcc - (3.3 V + 1.0 Vbe)) = 9V across a 400ohm resistor so 22 mA which is a beta of like 5)

At 7.074MHz with second stage disconnected, it looks really nice, base going from -1.02V to 1.88V and collector going from 1.36V to 15.2V (:o).

Input before cap is 440mV to 3V with no power (at 28MHz, see prev photo)

Common collector is a good voltage buffer (i.e. only current gain)

What I learned today:
- Common emitter: i mostly know how this works already. control is at base, output is at collector, and there's a resistor from collector to Vcc (and sometimes a resistor from emitter to GND also for degeneration, but emitter can also just go to ground). base current is amplified at collector (well that's just core BJT functionality but whatever), when base is on then collector can conduct to ground (electrons at emitter are attracted to holes introduced at base assuming NPN but because of BJT properties the base is really bad at capturing those so they flow through the thin P layer to the collector, the percentage that get to base is like 1/beta or something), so it's inverting. good for voltage gain.
- Common base: wtf is this lol, only learned about it today really in cascodes. it's a current mirror. basically the collector is attached to power and the emitter is attached to a current source. the base is kept constant (usually not ground though, biased to some voltage at least one Vbe (like 0.7V) above the emitter). electrons flow from emitter to collector so the amount of electrons flowing in at the emitter determine how many electrons flow out of the collector. in a cascode, this is useful because the Miller effect (parasitic capacitance that increases with inverting voltage gain) is lessened at the bottom common emitter because not much voltage gain is needed, common base only wants current.
- Common collector: heard of it before i think? makes more sense than common base anyway. control is at base, collector attached to Vcc, output at emitter with a resistor to ground. emitter changes its voltage so it's always 1 Vbe/"diode" drop (like 0.7V again) below base. electrons still flow from emitter to collector here, current through resistor is variable with voltage. anyway i'm tired but kinda understand this one, it'll just always be a diode drop below.

And those are the 3 most common BJT amplifier types, all of which I'm using now!

Note: when I built this I changed the 1.5k on the first base to a 2.2k, the 660 on the second collector to a 330 (made from 3 parallel 1Ks), and the 2.2k/3.3k for RD16HHF1 bias to a 1k/10k, and cap on input wasn't there
![yippee!](image-25.png)

Also just a bit more reflection: the old version didn't work probably because of the transistors being too slow/Miller capacitance/something. So we'll fix that with a cascode (inverting voltage gain is minimal I think although not fully convinced by my simulation but we'll see). But the cascode has a high output impedance so it can't drive the MOSFET easily, it'll get loaded down I think. So we'll add a common collector to act as a voltage follower which has very low output impedance.

holy crap i think it might work and this is even on a *breadboard*

![waoh](./IMG_9493.jpg)

...the RD16HHF1 did things but it got too hot and i shorted the gate to the source. :(((

but i've learned a lot more about bjts while building this!

i'll try to design the next board to use the ground plane as a heatsink, pretty sure that's a better idea. but first, checking to make sure i didn't break the preamp driving its output into ground.

wellllll i destroyed a 2n3904 by doing that. :( but it was only the last one and i have a bunch more so i replaced it and it works now, although now peak to peak is only like 9V?

also OUCH the 165ohm resistor on the collector of the common base transistor is getting quite hot and we've made an RTD, it only has a resistance of like 120 ohms now. wompity womp

(330 made from 3 parallel 1Ks was also getting a bit warm)

Ok peak to peak is back to ~10V once the resistor cooled down, but that's still worse than before, maybe the 2N3904 I picked is weaker?

I tried another 2N3904 and it's still not ideal, looks less squarey, ?? will attach picture in a bit

might try to solder this preamp to see if perf better or try to get one working more squarily in sim

Rise time and fall time are the amount of time for the transistor to go into or come out of saturation/cutoff. If you always operate a BJT in active mode it can go fast. Honestly, a fast FET is likely better for this. e.g. https://www.mouser.com/datasheet/2/196/Infineon_IRLML2060_DataSheet_v01_01_EN-3363619.pdf

Let's try building this one and seeing if it looks any better/more swing
![new](image-26.png)

Sim results:
![Cascoded](image-28.png)

I'd also be interested to compare it to a simple common emitter (which can be achieved by replacing Q4 with a wire I think), it has less swing in LTspice but curious if capacitance affects it any more in reality

This is without Q4/just the common emitter
![Just CE](image-27.png)

Wow the Miller effect is real! :o

soooo this is only 5Vptp when built. idk if i massively fricked up or what happened (IMG_9503). At 500kHz (easy peasy) it's 9.44Vptp (about what was predicted) and looks like a quite nice square wave lol. 1MHz also looked fine.

it's already starting to get clipped at 5MHz, only 7.76Vptp

also the output transistor is getting *hot* (which probably makes sense, 400mW dissipated according to LTspice)

wait what at 5MHz when I disconnect the common collecotor I'm getting 11.5Vptp, 14MHz is still 11Vptp, but 28MHz is 7.4Vptp

why is adding another transistor at the end messing things up so much?

Also was just curious, without cascoding we get ~6Vptp at 28MHz and it was 7.4Vptp with so it definitely improves things but not enormously

Let's try going back to old amp and checking how it behaves

Old amp is 9Vptp at 28MHz. that *should* be enough. IMG_9509

It looks nicer without the last common collector attached, IMG_9510 (3.36V - 12.7V) From now on, all images will be w/out common collector attached unless specified otherwise

The Miller effect **is** real! Same conditions as last photo but also with the common base bypassed by a wire, it's worse IMG_9511. That's pretty cool

Let's make this better!

Replacing 10K between bases with a 5.1K made things worse IMG_9512

Stronger bias resistors (effectively everything halved, 2.2K down is 1K, 10K between the two bases is 5K, 22K up is 10K) seems to be better? IMG_9513 Actually maybe not, waveform looks better but less swing

What about going back to old bias resistors and making emitter 33 instead of 50? It's definitely lower! But again less swing IMG_9514

Let's try halving the two lower bias resistors (10K between bases now 5K and 2.2K down is now 1K). And we now have a lower triangle IMG_9515

With this configuration we expect to see it low for longer with smaller spikes, and we do, but the spikes aren't very straight in reality IMG_9517
![alt text](image-29.png)

Replacing bottom 2.2K with 1K yields better results IMG_9518

Just for fun, IMG_9519 is same configuration as 9518 except common base is bypassed with a wire, Miller capacitance continues to matter

wtf so i was playing around for a while and this is like amazing how IMG_9521 CH2 is bottom (input), CH1 is top (output)
The 165ohm was getting a bit toasty but that's fineeeee
![wowowowowowow](image-30.png)
![](IMG_9521.jpg)

min is around 1.1V, max is around 11.2V

lol it's not linear at all and will turn anything into a square wave but that's fine for this purpose (hmmmmm maybe i should use fast logic level mosfets instead....hmmmmmm)! we can try to build a linear amplifier later when we have a function generator just for fun

IMG_9523 and IMG_9524 is this without cascoding

Also, something funny is that the output should be 180 degrees out of phase with the input (it's an inverting amplifier), but the delay is so bad that they're roughly the same. Doesn't matter :)

Oddly, at like 15MHz it's only 8Vptp, what's happening? Is the gain actually decreasing a lot but because of ringing it looks higher? (e.g. rpi input Vptp is 5.4V which is just obviously wrong)

And then at 22MHz it's back to 9.28Vptp and less squarey

28MHz is at least 3.6dB lower in voltage than 500kHz = ratio of 1.514 so 8Vptp?? maybe? or wait is this power idk decibels are weird

14.3 dB at 500kHz, 11.1 dB at 28MHz. 1 Vrms = 0 dB. so uh 5.188V vs 3.589V at fundamental frequency? idk maybe this sucks

10.523dB at 28MHz vs 11.985dB at 500kHz for fundamental frequency in simulation

so 1.73dB more lost in real life?

wait idk but really weird that Vrms is lower (like 6.5V) at 15MHz than 28MHz (like ....okaayyyy still around 7V when it should be like 7.5 in sim so that's 290 mW vs 340 mW, and CH2/RPi input Vrms is like 2.6V which is higher than the 2.38 it should be so maybe weird oscilloscope artifacts idk)

wow diodes are slow, at least the ones i have are anyway
![diodes](image-31.png)
![resistors](image-32.png)

I ended up using 100ohm instead of 330ohm resistors between the bases because that produces a cleaner waveform, idk why though /shrug

With 330ohm resistor from output to 13.3V, we get 4.72V minimum. With no resistor, we get 1.3V minimum. So that means the resistor is dropping (13.3 V - 4.72 V) = 8.58 V. 8.58 V / 330 ohms = 26 mA of current through it. That seems to suck.

10K we get 1.44V as lowest, so 12 mA?

2.2K we get 2V as lowest, so 51 mA? That seems good

...oops i was measuring the base of the second transistor, not the emitters. :facepalm: but the common collector delivering 50 mA is pretty good!

At 28MHz:

10.6 V / 165 ohms = 64 mA matches simulation

With a 81.2ohm resistor to ground, maximum voltage is ~8.2V, 8.2 V / 81.2 ohms = can source 100 mA we're cooking

81.2 ohm resistor to 13.3V, minimum voltage is 5.2 V, 13.3 V - 5.2 V = 8.1 V, 8.1 V / 81.2 ohms = can sink 100 mA we're cooking

Waveform kinda looks like crap though when going this fast

Now 110ohm resistor to ground:
9.28 V / 110 ohms = 84 mA sourced

110ohm resistor to 13.3V:
(13.3 V - 4 V) / 110 ohms = 85 mA sunk

With a 110ohm to ground and a 110ohm to power, minimum 3V, maximum 9.7V, simulated was 3V to 10.3V so not bad!

6.16 Vptp from push pull (now only 3 to 9.1 and idk why), 4.8Vptp from before it

With 330ohm to ground and 330ohm to power, between 7.7 and 8 Vptp from push pull.

Modifying the simulation to this (two changes which don't exist IRL: adding 40ohm resistor on Q3 collector and making 50ohm resistors 70ohms on collectors of Q5 and Q6) results in these peak to peak voltages with those corresponding loads:
![](image-33.png)

And it still drives the MOSFET well in simulation:
![wow](image-34.png)

yoooo and if I bypass the push pull then the peak to peak voltage with 110ohm up and down is 4.6V, it was 4.8V IRL :)

And if I bypass it with 330ohm up and 330ohm down Vptp was (10.2 V - 2.8 V) = 7.4V in sim...and IRL :)

If we connect the output of the common collector directly to the MOSFET, it draws 6W of power on average for 14W of transmission power. If we connect the output of the push-pull to the MOSFET, it draws 3.47W of power on average for 14W of transmission power. So the push-pull stage is definitely doing something :)) (although why didn't it transmit when I tried this before? idk although the real transistor is less ideal so maybe it needs stronger drive idk)

next iteration: use this https://www.mouser.com/ProductDetail/Aavid/581102B00000G?qs=PatHuWLFIbtpJJxTIzWZLQ%3D%3D and make space on PCB for it

Data in scope_data_0 folder, CH1 is output and CH2 is input, this is for the final driver schematic with no load i.e. this picture but with the IRL values (50 ohm resistors are used instead of 70 ohms and the 40 ohm resistor doesn't exist)

![alt text](image-35.png)

Data with a 105ohm resistor up and 105ohm resistor down is in the scope_data_1/ALL0001 folder (verify: ptp = 6.64V)

Data with a 330ohm resistor up and 330ohm resistor down is in the scope_data_2/ALL0002 folder (verify: ptp = 8.08V)

Data with no load at 7MHz is in the scope_data_3/ALL0003 folder (verify: it's slow and 9.6Vptp)

returned oscope :( time to start on kicad now though! with Bf=60 we get 11.5W out for 3.05W dissipated through transistor, 80% efficient, not terrible! I could try to go for more power but that doesn't seem worth it. Also, we're dangerously close to the maximum Vds (max 50V, peaking at 41V during normal operation and going higher otherwise). If run off 12V, peak voltage is 37V during normal operation (again, above that for like 20us but that's sim so who knows if it's real) for 8.97W out dissipating 2.5W. And I might get some extra components to swap around because the board layout doesn't dictate the components.

Also, was planning on adding another section for an alternative push-pull gate driver using [these guys](https://www.mouser.com/datasheet/2/196/Infineon_IRLML2060_DataSheet_v01_01_EN-3363619.pdf).