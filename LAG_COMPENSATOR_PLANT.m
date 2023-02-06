clc
clear all

K = 7000
pm_req = 45
tol = 15

n = K * [1 0.5]
d = [1 75.2 365 70 0]

g_uncompensated = tf(n, d)
omega = logspace(-4, 4, 1000)
[mag, phase] = bode(g_uncompensated, omega)
mag = 20*log10(mag)
phase_req = -180 + pm_req + tol

i = 1
while phase(i) >= phase_req
    i = i+1
end
w_gc = omega(i)
T = 10/w_gc

m_gc = mag(i)
b = 10 ^ (m_gc/20)

nc = [T 1]
dc = [b*T 1]

gc = tf(nc, dc)

ncs = conv(n, [T 1])
dcs = conv(d, [b*T 1])

gcs = tf(ncs, dcs)
bode(g_uncompensated, omega)
hold
bode(gcs, omega)