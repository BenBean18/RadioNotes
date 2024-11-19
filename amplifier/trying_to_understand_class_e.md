Resources used:
https://www.reddit.com/r/amateurradio/comments/lt33rl/what_are_common_rf_power_transistors/
and PDFs linked here and https://people.physics.anu.edu.au/~dxt103/class-e/ and the actual Class E paper https://people.physics.anu.edu.au/~dxt103/160m/class_E_amplifier_design.pdf which tells me that $V_0 = 0 \text{V}$ for a FET and https://eng.libretexts.org/Bookshelves/Electrical_Engineering/Electronics/Microwave_and_RF_Design_V%3A_Amplifiers_and_Oscillators_(Steer)/04%3A_Power_Amplifiers/4.03%3A_Switching_Amplifiers_Classes_D_E_and_F and http://www.norcalqrp.org/files/Class_E_Amplifiers.pdf and **https://ludens.cl/Electron/RFamps/RFamps.html** (from a while ago when I was trying to design HPR amp) and uh a textbook which could be useful later  https://d1.amobbs.com/bbs_upload782111/files_45/ourdev_672470C259C6.pdf and https://www.qsl.net/va3iul/ is awesome and https://ocw.mit.edu/courses/6-976-high-speed-communication-circuits-and-systems-spring-2003/ is a great resource and specifically https://ocw.mit.edu/courses/6-976-high-speed-communication-circuits-and-systems-spring-2003/74927837820d5a11a2443b5b86ce0f50_guest3.pdf (guest lecture on power amplifiers)

Currently watching this video: https://www.youtube.com/watch?v=Tgrakttus3c

Notes:
- There are two main types of amplifiers: linear and nonlinear
- Linear amplifiers preserve the amplitude of the signal, nonlinear amplifiers don't
- Helpful graphic distinguishing the amplifier regions:
![](linear.png)
- 6.976: “Linear PA” generally refers to a PA which operates at constant gain, needs to preserve amplitude information, Useful for modulation schemes with amplitude modulation (QPSK, 8-PSK, QAM)
- 6.976: “Non-linear PA” generally refers to a PA designed to operate with constant PIN , output power varies by changing gain, Useful for constant-envelope modulation schemes (GMSK), **high efficiency**
    - **Class E apparently needs amplitude. So that's bad for QPSK.**
    - https://dsp.stackexchange.com/questions/51220/what-is-a-constant-envelope-modulation
    - Constant envelope: information carried in **phase** not amplitude, so ideally QPSK is constant-amplitude, but it's not in practice? idk need to read more, but it should definitely work for FT8 (frequency-shift keying is explicitly called out in https://en.wikipedia.org/wiki/Constant_envelope)
    - OK THIS MAKES SENSE WITH MORE SLEEP: https://dsp.stackexchange.com/questions/70411/use-of-pulse-shaping-in-digital-modulation. QPSK is modulating the amplitude of the in-phase and quadrature components, so it is effectively amplitude modulation and is not constant-envelope. Here's a time-domain image using my fft_by_hand.py program in this folder:
    ![](qpsk.png)
- Load-line theory: https://en.wikipedia.org/wiki/Load_line_(electronics) "The load line, usually a straight line, represents the response of the linear part of the circuit, connected to the nonlinear device in question. The points where the characteristic curve and the load line intersect are the possible operating point(s) (Q points) of the circuit; at these points the current and voltage parameters of both parts of the circuit match." **load line is shown in next image**

Making amps more efficient:
- Turning on transistor not all the time like in a linear amplifier, just some of the time
- Like in a Class B amplifier (Class A is a linear, not very efficient amplifier)
- Load line when this happens:
![](load_line.png)
- This is more efficient because (from video) the transistor is either on or off; it's not on for the entire thing
![](switching.png)

Class E:
- 1:30 in video
![](class_e.png)
- Need 50% duty cycle
- RFC = radio frequency choke, blocks high-frequency AC
- Zero-voltage switching on turn-on and turn-off edges, zero current when switching, reduced losses during transition phases --> improved efficiency
- Can be built with single switching transistor
- Case study: 5 V, 0.5 W, 50 ohm impedance, 5 MHz
- Magical calculations to get:
![](case_study_calcs.png)
- Useful for calculating output power I think
- Q factor for matching network is dimensionless, apparently low values are lossier but wider bandwidth https://www.reddit.com/r/rfelectronics/comments/1d7gwoz/q_factor_in_matching_networks/
- Using idealized switch instead of transistor
- Takes a bit to reach steady state
- Voltage on switch exceeds 18V with 5V input, huh. 4-5x supply voltage when selecting transistor.
- Comparing Q-factor:
    - Q = 10: more sine wavey, cleaner signal, narrower bandwidth
    - Q = 3: less sine wavey, larger harmonics, more distorted, wider bandwidth
- Formulas may not give best values, to evaluate check voltage in switching element
- Should look like:
![](switching_voltage.png)
- How to optimize:
![](optimization.png)
- Can confirm circuit is optimized by looking at current through switch
- Using a real transistor in LTspice?
- Used SI2304DS, max drain-source is 30V, max drain current is 1.7A
- Note: transistor already has output capacitance, can modify capacitor in parallel to be less

That was a GREAT video
https://www.youtube.com/watch?v=Tgrakttus3c

Build: (todo watch at a more reasonable hour) https://www.youtube.com/watch?v=qN18wjy5Xwc
- Used logic gate driver to drive MOSFET
- Doing PCB design, cool
- Thermal imaging to see where power is being lost :)
- Measure statements in LTspice
- This guy has a frequency generator, oscilloscope, and spectrum analyzer

Ok I should go to sleep, but this was really useful (and I think I now know why the amplifier was heating up so much when I was trying to transmit QPSK. I'd be interested to try just transmitting a square wave and seeing how that goes. I'll likely have to go with a linear amplifier for rocketry, should reference that MIT guest lecture at a more reasonable hour. Learning about radio stuff when I have lots of work to do ~~tomorrow~~today is probably not ideal but whatever, break is coming up soon :))

## My amplifier
oops this should be 10m (28mhz) not 10mhz, misleading name, my bad i was tired and don't want to rename rn
1. class_e_10mhz_orig.asc from tool
2. class_e_10mhz_optimized_ideal_components.asc after playing around, switching voltage waveform is much better
![](yay.png)
waittttt.... only 4W out of the resistor?
oh shoot increasing resistance would decrease power by equations in video. time to optimize more

2(a). Other optimization path: `class_e_10mhz_orig_opt2.asc` (more trial and error, idk how I got to increasing R in the previous one which decreases output power according to video eqns)

This is a LOT better:
![more yay](yay2.png)

12.77 W out / 12.885 W in = 99% efficient...using theoretical components but I'm still very optimistic :)

3. class_e_10mhz_optimized_real_components.asc: looks really bad, didn't realize that the transistor I wanted to use (SPP21N50C3) has an output capacitance of **1200** pF when the largest capacitor in this is 150. time to find a different transistor oopsies, but this explains why I've been banging my head against the wall for a bit (:

could I use the one I already have? no, too low power for what I want to do :(

back to reddit thread https://www.reddit.com/r/amateurradio/comments/lt33rl/what_are_common_rf_power_transistors/

MRF101BN is $25 which is dumb but I'm just curious if it works in sim, is there a spice model?

https://www.mouser.com/datasheet/2/302/MRF101AN-1510799.pdf

Output capacitance is 43 pF, that's a lot more manageable

3(a). class_e_10mhz_opt2_real_components.asc

Trying https://www.qsl.net/in3otd/electronics/LDMOS_models/RD16HHF1/RD16HHF1_LTspice.html, capacitance of max 145 pF is a bit high but less than our 170 pF cap so might be fine? we'll see

https://ieeexplore.ieee.org/document/1523078 optimization help?

C2 (cap next to inductor right before load) is **very** important to the amount of power produced

https://www.mouser.com/ProductDetail/NXP-Semiconductors/AFT09MS015NT1?qs=7imfUp6rdT0GP%2F%252B8RBSTBw%3D%3D could be good also (rocketry as well!)

ok I really need sleep. current optimized model using RD16HHF1 has 13.233 W out / 15.242 W in = 86.8% efficiency which is not ideal but I need sleep and may use a different transistor anyway, using the AFT09MS015NT1 (linked above) would be good overlap with rocketry and allows me to test that one which i was thinking about using anyway

245am rambling is not fun, going to sleep now

### 11-19-2024 aka actual morning
Class E can *only* be used for a square wave; it erases amplitude modulation (forces a constant envelope waveform). 

RPiTX does amplitude modulation through varying the output power of the GPIO pin: https://groups.io/g/rpitx/topic/how_does_am_ssb_modulation/28976987

NanoVNA would be good to get

But back on task, according to Wikipedia, Class AB and Class D are the most commonly used audio amplifiers. 

wait this is cool https://github.com/threeme3/usdx. They use a Class E amplifier with envelope elimination and restoration (basically, split signal into phase and amplitude, give phase to Class E, and modulate the power going to Class E to correspond with amplitude) https://core.ac.uk/download/pdf/148657773.pdf

It'll be probably simpler to start with a Class AB amplifier.

Note from RFamps.html (linked at top):
"When building such an amplifier it's absolutely critical to minimize stray inductances. The 560pF capacitor needs to be soldered directly to the transistor's body, not one centimeter away. It needs to be a chip capacitor, because any wire terminals at all will contribute too much stray inductance. It's best to split it up into two capacitors of half the value, and solder them to the transistor on both sides of the drain terminal. Any deviation from this will make the amplifier behave less like the calculation indicates. And even if you follow these recommendations, you need to keep in mind that this design method is very simplistic, for example by not considering the inductance of the drain connection inside the transistor. One can usually get away with such simplifications at HF, but at 52MHz it's risky, and on even higher bands it definitely no longer works well enough. At VHF and higher one needs to design the matching network for the load impedance the transistor needs at its drain terminal, and not the one it needs inside, at its actual drain on the silicon chip. This load impedance needs to be looked up in the data sheet, which usually gives it for a single or a few operating frequencies and power levels. It often needs to be interpolated, if your application is not a completely standard one for the chosen transistor."

## Some kind of linear amplifier
This seems helpful:
https://www.electronics-tutorials.ws/amplifier/class-ab-amplifier.html

Or class B? this also seems helpful
https://www.allaboutcircuits.com/technical-articles/introduction-to-class-b-power-amplifiers/

![](class_b.png)

![](10meter_lc_network.png)

ok so for biasing we want the voltage added to be approximately the transition voltage I think

ok what about a single transistor tuned amplifier

https://ludens.cl/Electron/RFamps/RFamps.html

This seems useful

https://www.w6pql.com/1_kw_sspa_for_1_8-54_mhz.htm

Class A amplifier from same person with Class E video: https://www.youtube.com/watch?v=GtFnkXar5JU&list=PLT84nve2j1g_UO_7hj0HPrVwNj3NGQeES&index=6 Taking notes below
- Incredibly inefficient (25% normally)
- Class A: entire signal amplified by single element
    - Class B/Class C: broken up into chunks so multiple elements amplifying
![](transistor_operation.png)
- Biasing required to keep transistor in linear region
- Gain is current dependent
- Closed-loop current control for good linearity -- stabilize gain at fixed value
    - Providing negative feedback
- If gain of amplifying element is high enough in negative feedback amplifier, then gain of entire amplifier only depends on attenuation $\beta$
![](feedback.png)
- Inductor opposes current flow
    - Interesting thing about inductors: voltage is derivative of current, kind of
    - Lets our amplifier go from 0V to 2VCC (-VCC to +VCC), increases max efficiency to 50%
![](class_a_schematic.png)
- Other approach: use transformer to remove DC
![](transformer_a.png)
- Negative feedback loop is important