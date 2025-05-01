

function averageW = ExtrinsicVicsekEtaVals(N,L,v0,U,eta,tMax,tVals)

%% Variables
dt = 1;
timescale = length(tVals);
cat = zeros(2*N,timescale); % to add future time
inta = -pi;
intb = pi;
noise = (inta + (intb-inta).*rand(N,tMax));
psi = exp(1i*noise); % Noise
Z = zeros(N,timescale);
M = N*pi*U*U/(L*L);

cat = zeros(2*N,timescale);
r = L*rand(2*N,1);
r = horzcat(r,cat);
% angle of velocity for all particles
theta = 2*pi*rand(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);
%v = v0*exp(1i*theta); - which is best to use - matrix or scalar

%% Initial Conditions


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
    % PlotVicsekMove(r,L,N,i,v)

    % Plotti
    
    PlotVicsekMove(r,L,N,i)
    % frame = getframe(gcf);
    % writeVideo(vid,frame)
end
% close(vid)

Whalf = W(tMax/2:tMax);

averageW = sum(Whalf)/(timescale/2)


% averageW = sum(W)/(length(tVals))
tVals(timescale) = [];
W(timescale) = [];
tVals(timescale-1) = [];
W(timescale-1) = [];

figure(3)
plot(tVals,W, '-', 'LineWidth', 4,'DisplayName',strcat('Eta = ',num2str(eta)))

ylim([0 1]);
xlabel('Time')
ylabel('Order Parameter Size')
title('Order Parameter Size over Time')
fontsize(16,"points")
hold on
end