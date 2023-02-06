clc
clear all

phase_margin_required = 50
K = 40
tol = 10
gain_margin = 10

n = [K]
d = [1 2 0]

g_u = tf(n, d)
omega = logspace(-4, 4, 1000);
[mag, phase] = bode(g_u, omega)
mag = 20*log10(mag)

[gm, pm, pcf, gcf] = margin(g_u)

extra_phase_lead = phase_margin_required - pm + tol
alpha = (1 - sind(extra_phase_lead))/(1 + sind(extra_phase_lead))

mag_alpha = -20 * log10(1/sqrt(alpha))

r = 1
while mag_alpha <= mag(r)
    r = r + 1
end

freq_at_alpha = omega(r)
T = 1/(sqrt(alpha) * freq_at_alpha)

nc = [T 1]
dc = [alpha*T 1]

ncs = conv(n, nc)
dcs = conv(d, dc)

gcs = tf(ncs, dcs)
bode(g_u, omega)
hold
bode(gcs, omega)