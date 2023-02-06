% K/s(1 + 0.1s)(1 + 0.2s)
% Kv = 30
% Pm >= 40
% tol = 10
% Lag compensator

clc
clear all

K = 30
tol = 10
phase_margin_req = 40

n = [K]
d = [0.02 0.3 1 0]

g_uncompensated = tf(n, d)
omega = logspace(-4, 4, 1000)

[mag, phase] = bode(g_uncompensated, omega)
mag = 20*log10(mag)
phase_req = -180 + phase_margin_req + tol

r = 1
while phase_req <= phase(r)
    r = r + 1
end

wgc_new = omega(r)
T = 10/wgc_new

b = 10^(mag(r)/20)

nc = [T 1]
dc = [b*T 1]

ncs = K*nc
dcs = conv(d, dc)
gcs  = tf(ncs, dcs)

bode(g_uncompensated, omega)
hold
bode(gcs, omega)