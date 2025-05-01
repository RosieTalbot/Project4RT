%% Extrinsic Function


% N = 1000; % number of particles
% L = 20; % size of domain
% v0 = 0.1; % speed of all particles
% U = 4; % interacting radius
% eta = 1;
% tMax = 1000
% tVals = 1:1:tMax
% averageW = ExtrinsicVicsek(N,L,v0,U,eta,tMax,tVals,theta,r)
% 
% r = L*rand(2*N,1);
% r = horzcat(r,cat);
% 
% % angle of velocity for all particles
% theta = 2*pi*rand(N,1);
% % velocity of all particles
% v = v0*[cos(theta); sin(theta)];
% v = horzcat(v,cat);


function averageW = ExtrinsicVicsek(N,L,v0,U,eta,tMax,tVals,theta,r)

%% Variables
dt = 1;
cat = zeros(2*N,length(tVals)); % to add future time
inta = -pi;
intb = pi;
noise = (inta + (intb-inta).*rand(N,tMax));
psi = exp(1i*noise); % Noise
Z = zeros(N,length(tVals));
M = N*pi*U*U/(L*L);

% position of all particles at time 1 = r_t1 = x1,...,xN,y1,...,yN as a 2Nby1 matrix
% position of ith particle at time 1 = r_i_t1 = r([i,N+i],;)
% dirn/angle of velocities for particles = theta_i
% Circular Nbhds = U
% each centered at a x

%% Initial Conditions
% position of all particles 


%v = v0*exp(1i*theta); - which is best to use - matrix or scalar

%% Figure to test initial conditions
% figure(1)
% r = mod(r,L);
% % plot(r(1:N,i),r(N+1:2*N,i),'.b','MarkerSize',15)
% xlim([0 L]);
% ylim([0 L]);
% quiver(r(1:N,1),r(N+1:2*N,1),v(1:N,1),v(N+1:2*N,1),'MarkerSize',15)
% axis square
    
% close all
% vid = VideoWriter("VicsekEtaaaaaa.mp4",'MPEG-4');
% open(vid)


%% Time loop
for i = 1 : tMax-2
    
%% Calculating new thetas

  
    a = [r(1:N,i) r(N+1:2*N,i)];
    dist = pdist(a);
    D = squareform(dist);

    D1 = D<=U & D~=0;

    SumD1 = sum(D1,1)';
    SumD1(SumD1==0) = 10000000;
    RePsi = real(psi(:,i));
    CompPsi = (psi(:,i) - RePsi)/1i;
    PsiTheta = atan2(CompPsi,RePsi);

    distsin = D1*sin(theta)./SumD1 + eta*RePsi;
    distcos = D1*cos(theta)./SumD1 + eta*CompPsi;
    newtheta = atan2(distsin,distcos);

    theta = newtheta;
    
    Z(:,i) = (1/N)*exp(1i*theta);
    
    v(1:N,i+1) = v0*cos(theta);
    v(N+1:2*N,i+1) = v0*sin(theta);

    phi = 1/(v0*N)*sqrt((sum(v0*cos(theta)))^2+(sum(v0*sin(theta))^2));

    r(1:N,i+1) = r(1:N,i) + dt*v(1:N,i+1);
    r(N+1:2*N,i+1) = r(N+1:2*N,i) + dt*v(N+1:2*N,i+1);
     
%% Updating values    
    % Angle and noise
 
    r = mod(r,L);
    %% Order parameter
    Ztot = sum(Z,1);
    W = abs(Ztot);
    PlotVicsekMove(r,L,N,i,v)

    % Plotting
    
    % PlotVicsekMove(r,L,N,i)
    % frame = getframe(gcf);
    % writeVideo(vid,frame)
end
% close(vid)
Whalf = W(tMax/2:tMax);

averageW = sum(Whalf)/(length(tVals)/2)


tVals(length(tVals)) = [];
W(length(tVals)) = [];
figure(3)
plot(tVals,W,'.','MarkerSize',15)
ylim([0 1]);
xlabel('Time')
ylabel('Order Parameter Size')
title('Order Parameter Size over Time')
fontsize(16,"points")
hold on
end