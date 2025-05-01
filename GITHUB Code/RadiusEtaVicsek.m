rng(1)
%% Loop
N = 3000;
L = 32;
v0 = 0.05;
tMax = 3000;
tVals = 1:1:tMax;

cat = zeros(2*N,length(tVals));
r = L*rand(2*N,1);
r = horzcat(r,cat);
% angle of velocity for all particles
theta = 2*pi*rand(N,1);
% velocity of all particles
v = v0*[cos(theta); sin(theta)];
v = horzcat(v,cat);
%v = v0*exp(1i*theta); - which is best to use - matrix or scalar
UVals = 0:0.1:1;
EtaVals = 0:0.1:1;
Udata = zeros(length(UVals),length(EtaVals)+1);
for j = 1:length(UVals)
    U = UVals(j);
    disp(['U is: ',num2str(U)])
    OrdParam = zeros(1,length(EtaVals));
    for i = 1:length(EtaVals)
        eta = EtaVals(i);
        OrdParam(i) = IntrinsicVicsek(N,L,v0,U,eta,tMax,tVals,theta,r);
        disp(['eta is: ',num2str(eta)])
        disp(['W is: ',num2str(OrdParam(i))])
    end

figure(5)
plot(EtaVals,OrdParam,'LineWidth',4)
xlabel('Eta')
ylabel('Average W')
xticks(EtaVals)
title('Plot of W whilst varying Eta')
fontsize(16,"points")
hold on

Etadata = [EtaVals OrdParam];
Udata(j,:) = [U OrdParam];

end
UVals = [0 UVals]
Data = [UVals; Udata]
save VaryingUEta Data