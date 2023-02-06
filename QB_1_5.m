% Sketch the root locus for the open loop transfer function G
% 
% G(s) = K/s(s + 1)(s + 5)
% 

n = [1]
d = [1 6 5 0]

g = tf(n, d)
rlocus(g)
v = [-12 2 -8 8]
axis(v)
% axis('square')
grid