%% Time snapshots

N = 3000; % Number of Particles
L = 32; % Size of Domain
v0 = 0.1; % Speed of Particles
U = 1; % Interacting Radius
eta = 0.000001; % Noise Intensity
tMax = 3005; % Length of Simulation
tVals = 1:1:tMax; % T Values

cat = zeros(2*N,length(tVals));
r = L*randn(2*N,1);
r = horzcat(r,cat);
% angle of velocity for all particles
theta = 2*pi*randn(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);

% Intrinsic = IntrinsicVicsekTimeSnap(N,L,v0,U,eta,tMax,tVals,theta,r)

Extrinsic = ExtrinsicVicsekTimeSnap(N,L,v0,U,eta,tMax,tVals,theta,r)

function averageW = ExtrinsicVicsekTimeSnap(N,L,v0,U,eta,tMax,tVals,theta,r)

%% Variables
dt = 1;
cat = zeros(2*N,length(tVals)); % to add future time
inta = -pi;
intb = pi;
noise = (inta + (intb-inta).*rand(N,tMax));
psi = exp(1i*noise); % Noise
Z = zeros(N,length(tVals));
M = N*pi*U*U/(L*L);

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
    
    % PlotVicsekMove(r,L,N,i)
    

    if i == 1
        frame1 = getframe(gcf);
        exportgraphics(gcf,['SnapshotT0Eta1.png'])
        disp(['At time = 0, Psi is: ',num2str(W(i))])

    end

    if i == 300
        frame2 = getframe(gcf);
        exportgraphics(gcf,'SnapshotT300Eta1.png')
        disp(['At time = 300, Psi is: ',num2str(W(i))])

    end

    if i == 3000
        frame3 = getframe(gcf);
        exportgraphics(gcf,'SnapshotT3000Eta1.png')
        disp(['At time = 3000, Psi is: ',num2str(W(i))])

    end
    
end

averageW = sum(W)/(length(tVals))

end


%% Intrinsic Function

function averageW = IntrinsicVicsekTimeSnap(N,L,v0,U,eta,tMax,tVals,theta,r)

dt = 1;
cat = zeros(2*N,length(tVals)-1); % to add future time
inta = -pi;
intb = pi;
psi = eta*(inta + (intb-inta).*rand(N,tMax)); % Noise
Z = zeros(N,length(tVals));
M = N*pi*U*U/(L*L);
disp(['Eta is: ' num2str(eta)])

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

        r(1:N,i+1) = r(1:N,i) + dt*v(1:N,i+1);
        r(N+1:2*N,i+1) = r(N+1:2*N,i) + dt*v(N+1:2*N,i+1);
        end
    
    r = mod(r,L);
    %% Order parameter
    Ztot = sum(Z,1);
    W = abs(Ztot);
    
    PlotVicsekMove(r,L,N,i,v);
    
    if i == 1
        % frame1 = getframe(gcf);
        % exportgraphics(gcf,'ISnapshotT0Eta1.png')
        disp(['At time = 0, Psi is: ',num2str(W(i))])

    end

    if i == 300
        % frame2 = getframe(gcf);
        % exportgraphics(gcf,'ISnapshotT300Eta1.png')
        disp(['At time = 300, Psi is: ',num2str(W(i))])

    end

    if i == 3000
        % frame3 = getframe(gcf);
        % exportgraphics(gcf,'ISnapshotT3000Eta1.png')
        disp(['At time = 3000, Psi is: ',num2str(W(i))])

    end
    
end
averageW = sum(W)/(length(tVals))

end
