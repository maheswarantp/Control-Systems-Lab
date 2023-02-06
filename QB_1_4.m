% Frequency Response
% 
% G(s) = 20/s(s+1)(s+4)
% 

% (a) Phase Margin
% (b) Gain Margin
% (c) Phase Cross over frequency
% (d) Gain Cross over frequency
% (e) Maximum resonance
% (f) Resonant frequency

clc
clear all

n = [20]
d = [1 5 4 0]

g = tf(n, d)
omega = logspace(-1, 1, 100)
bode(g, omega)

[gm, pm, pcf, gcf] = margin(g)
gm = 20*log10(gm)

% Resonance and Resonant freq
sys = feedback(g, 1)
w = logspace(-1, 1)
[mag, phase, w] = bode(sys, w)

[mp, k] = max(mag)
resonant_peak = 20*log10(mp)
resonant_freq = w(k)

% Bandwidth
n = 1
while 20*log10(mag(n)) >= -3
    n = n + 1
end

bandwidth = w(n)
