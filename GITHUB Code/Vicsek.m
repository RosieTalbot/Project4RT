%% Vicsek

N = 3000; % Number of Particles
L = 32; % Size of Domain
v0 = 0.1; % Speed of Particles
U = 1; % Interacting Radius
eta = 0.5; % Noise Intensity
tMax = 3000; % Length of Simulation
tVals = 1:1:tMax; % T Values


cat = zeros(2*N,length(tVals));
r = L*randn(2*N,1);
r = horzcat(r,cat);
% angle of velocity for all particles
theta = 2*pi*randn(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);
%v = v0*exp(1i*theta); - which is best to use - matrix or scalar

% Intrinsic = IntrinsicVicsek(N,L,v0,U,eta,tMax,tVals,theta,r)

Extrinsic = ExtrinsicVicsek(N,L,v0,U,eta,tMax,tVals,theta,r)