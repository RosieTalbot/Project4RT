%% Vicsek Model Simulation with Extrinsic Noise

%% Variables
N = 1000; % number of particles
L = 32; % size of domain
v0 = 0.1; % speed of all particles
U = 1; % interacting radius
eta = 0.1; % noise
tMax = 1000;
tVals = 1:1:tMax;
dt = 1;
cat = zeros(2*N,length(tVals)); % to add future time
inta = -pi;
intb = pi;
psi = eta*(inta + (intb-inta).*rand(N,tMax)); % Noise
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
vid = VideoWriter("VicsekExtEtaaaaaa.mp4",'MPEG-4');
open(vid)


for i = 1 : tMax-2
    
%% Calculating new thetas

    a = [r(1:N,i) r(N+1:2*N,i)];
    dist = pdist(a);
    D = squareform(dist);

    D1 = D<=U & D~=0;

    SumD1 = sum(D1,1)';
    SumD1(SumD1==0) = 10000000;

    distsin = D1*sin(theta)./SumD1;
    distcos = D1*cos(theta)./SumD1;

    newtheta = atan2(distsin,distcos);

%% Updating values    
    % Angle and noise
    for j = 1:N
        if newtheta(j) == 0
            theta(j) = theta(j) + psi(j,i);
        else
            theta(j) = newtheta(j) + psi(j,i);
        end
        % Order parameter
        Z(j,i) = (1/N)*exp(1i*theta(j));
        % Velocity
        v(1:N,i+1) = v0*cos(theta);
        v(N+1:2*N,i+1) = v0*sin(theta);
        % Position
        r(1:N,i+1) = r(1:N,i) + dt*v(1:N,i+1);
        r(N+1:2*N,i+1) = r(N+1:2*N,i) + dt*v(N+1:2*N,i+1);
        
    end
    
    r = mod(r,L);
    %% Order parameter
    Ztot = sum(Z,1);
    W = abs(Ztot);
    
    PlotVicsekMove(r,L,N,i,v)

    % Plotting
    
    % PlotVicsekMove(r,L,N,i)
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