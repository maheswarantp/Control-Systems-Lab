clc
clear all

K = 40
phase_margin_req = 50
tol = 10

n = [K]
d = [1 2 0]

g = tf(n, d)
omega = logspace(-1, 2, 1000);
[mag, phase] = bode(g, omega)
mag = 20 * log10(mag)

[gm, pm, pcf, gcf] = margin(g)

extra_phase_angle = phase_margin_req - pm + tol
alpha = (1 - sind(extra_phase_angle))/(1 + sind(extra_phase_angle))

magnitude = -20 * log10(1/sqrt(alpha))

i = 1
while magnitude <= mag(i)
    i = i+1
end

w_gc_new = omega(i)
T = 1 / (sqrt(alpha) * w_gc_new)
ncs = K * [T 1]
dc = [alpha*T 1]
dcs = conv(d, dc)

gcs = tf(ncs, dcs)
bode(g)
hold
bode(gcs)