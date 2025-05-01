function averageW = IntrinsicVicsekEtaVals(N,L,v0,U,eta,tMax,tVals)

%% Variables
dt = 1;
timescale = length(tVals);
cat = zeros(2*N,length(tVals)-1); % to add future time
inta = -pi;
intb = pi;
psi = eta*(inta + (intb-inta).*rand(N,tMax)); % Noise
Z = zeros(N,length(tVals));
M = N*pi*U*U/(L*L);

cat = zeros(2*N,length(tVals));
r = L*randn(2*N,1);
r = horzcat(r,cat);
% angle of velocity for all particles
theta = 2*pi*randn(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);

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
    
    %% Order parameter
    r = mod(r,L);
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