% G(s) = 25/s^2 + 8s + 25

% (a) Damping ratio
% (b) Rise time
% (c) Peak time
% (d) Percentage overshoot
% (e) Settling time
clc
clear all

n = [25]
d = [1 8 25]

g = tf(n, d)
step(g)

Wn = sqrt(n(1))
Z = d(2)/(2*Wn)
Wd = Wn*sqrt(1 - Z*Z)

t = 0:0.001:5
[y, t] = step(g, t)

% Rise time = time to rise to 0 - 100 % for underdamped and 10 - 90% for
% overdamped systems

rise_time_theoretical = (pi - acos(Z))/Wd

r = 1
while y(r) <= 1.001
    r = r + 1
end
rise_time = (r - 1) * 0.001

% Peak time = time to reach peak of the response
peak_time_theoretical = pi/Wd
[ymax, i] = max(y)
peak_time = (i - 1) * 0.001

% Percentage overshoot theoreticak
percentage_overshoot_theoretical = exp((-pi * Z)/(sqrt(1 - Z*Z))) * 100
percentage_overshoot = (ymax - 1) * 100

s = size(t)
s = s(1)

while (y(s) >= 0.98 && y(s) < 1.02)
    s = s -1 
end

settling_time_theoretical = 3/(Z*Wn)
settling_time = (s - 1)*0.001