% Write a transfer function for the following systems.
% (a) under damped system
% (b) undamped system
% (c) over damped system
% (d) critically damped system

% For RLC Circuit
clc
clear all 

Wn = 1000
L = 0.001
Z = 1
C = 1/(Wn*Wn*L)
R = 2*Z*sqrt(L/C)

n = [1/(L*C)]
d = [1 (R/L) 1/(L*C)]

g = tf(n, d)
t = 0:0.0001:0.04
step(g, t)