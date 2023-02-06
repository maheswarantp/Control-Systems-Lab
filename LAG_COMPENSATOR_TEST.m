% 
% G(s) = K/s(s+2)
% Kv >= 10
% Pm >= 60
% tol = 10

% Kv = lt sG(s)
% k = 20
% G(s) = 20/s(s+2) ==> 20/s^2 + 2s

clc
clear all

K = 20
phase_req = 60
tol = 10

n = [K]
d = [1 2 0]

g_u = tf(n, d)
omega = logspace(-4, 4, 1000)
[mag, phase] = bode(g_u, omega)
mag = 20*log10(mag)

phase_available = -180 + phase_req + tol
bode(g_u, omega)

freq = 0.718
mag_at_freq = 22.4

T = 10/freq
B = 10^(mag_at_freq/20)

nc = [T 1]
dc = [B*T 1]
g_compensator = tf(nc, dc)

ncs = conv(n, nc)
dcs = conv(d, dc)

g_system = tf(ncs, dcs)
bode(g_u, omega)
hold
bode(g_system, omega)

% mag_at_freq = 20log(B)
% B = 10^(mag_at_freq/20)

% 10/freq
% 1+st/1+sBt