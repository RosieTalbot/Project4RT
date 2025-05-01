%% Vicsek Model Simulation with Extrinsic Noise

%% Variables
N = 1000; % number of particles
L = 32; % size of domain
v0 = 0.1; % speed of all particles
U = 1; % interacting radius
eta = 0.5; % noise
tMax = 1000;
tVals = 1:1:tMax;
dt = 1;
cat = zeros(2*N,length(tVals)); % to add future time
inta = -pi;
intb = pi;
noise = (inta + (intb-inta).*rand(N,tMax));
psi = exp(1i*noise); % Noise
Z = zeros(N,length(tVals));
M = N*pi*U*U/(L*L);

%% Initial Conditions
% position of all particles 
r = L*rand(2*N,1);
r = horzcat(r,cat);

% angle of velocity for all particles
theta = 2*pi*rand(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);

close all
vid = VideoWriter("VicsekEtaaaaaa.mp4",'MPEG-4');
open(vid)

%% Time loop
for i = 1 : tMax-2
    
%% Calculating new thetas

    a = [r(1:N,i) r(N+1:2*N,i)];
    dist = pdist(a);
    D = squareform(dist);

    D1 = D<=U & D~=0;

    RePsi = real(psi(:,i));
    CompPsi = (psi(:,i) - RePsi)/1i;
    PsiTheta = atan2(CompPsi,RePsi);

    distsin = D1*sin(theta) + eta*PsiTheta;
    distcos = D1*cos(theta) + eta*PsiTheta;

    newtheta = atan2(distsin,distcos);

    theta = newtheta;
    Z(:,i) = (1/N)*exp(1i*theta);
    
    v(1:N,i+1) = v0*cos(theta);
    v(N+1:2*N,i+1) = v0*sin(theta);

    r(1:N,i+1) = r(1:N,i) + dt*v(1:N,i+1);
    r(N+1:2*N,i+1) = r(N+1:2*N,i) + dt*v(N+1:2*N,i+1);
     
%% Updating values    
    % Angle and noise
 
    r = mod(r,L);
    %% Order parameter
    Ztot = sum(Z,1);
    W = abs(Ztot);
    
    PlotVicsekMove(r,L,N,i,v)

    frame = getframe(gcf);
    writeVideo(vid,frame)
end
close(vid)

averageW = sum(W)/(length(tVals));
tVals(1) = [];
W(1) = [];
figure(3)
plot(tVals,W,'.','MarkerSize',15)
ylim([0 1]);
xlabel('Time')
ylabel('Order Parameter Size')
title('Order Parameter Size over Time')
fontsize(16,"points")