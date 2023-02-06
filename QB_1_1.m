%  transient specifications 
% 
% G(s) = 16/(s^2 + 4s + 16)
% 
% (a) Damping ratio
% (b) Rise time
% (c) Peak time
% (d) Percentage overshoot
% (e) Settling time

clc
clear all

n = [16]
d = [1 4 16]

g = tf(n, d)

Wn = sqrt(n(1))
Z = d(2)/ (2 * Wn)
Wd = Wn * sqrt(1 - Z*Z)

t = 0:0.001:5
[y, t] = step(g, t)

r = 1
while y(r) <= 1.001
    r = r + 1
end

riseTime = (r - 1) * 0.001
riseTime_theoretical = (pi - acos(Z))/Wd

[ymax, i] = max(y)
peakTime = (i - 1) * 0.001
peakTime_theoretical = (pi)/Wd

percentage_overshoot = (ymax  - 1) * 100
percentage_overshoot_theoretical = exp((-pi * Z)/(sqrt(1 - Z*Z))) * 100

s = (size(t))
s = s(1)
while (y(s) > 0.98 && y(s) < 1.02)
    s = s - 1
end
settlingTime = (s - 1) * 0.001
settingTime_theoretical = 4 / (Z*Wn)