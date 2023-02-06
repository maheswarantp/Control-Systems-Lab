% Frequency Response
% 
% G(s) = 25/s(s+5)(s+3)
% 

% (a) Phase Margin
% (b) Gain Margin
% (c) Phase Cross over frequency
% (d) Gain Cross over frequency
% (e) Maximum resonance
% (f) Resonant frequency

clc
clear all
n = [25]
d = [1 8 15 0]

g  = tf(n, d)
omega = logspace(-1, 1, 100)
bode(g, omega)
[gm, pm, pcf, gcf] = margin(g)
gm = 20*log10(gm)

% Resonance and Resonant freq
sys = feedback(g, 1)
w = logspace(-1, 1)
bode(sys, w)
[mag, phase, w] = bode(sys, w)

[mp, k] = max(mag)
resonant_peak = 20*log10(mp)
resonant_freq = w(k)

% bandwidth = freq range in which magnitude of closed loop tf drops not
% more than 3db

r = 1
while 20*log10(mag(r)) >= -3
    r = r + 1
end

bandwidth = w(r)