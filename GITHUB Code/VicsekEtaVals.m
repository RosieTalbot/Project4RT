rng(1)
%% Loop
N = 3000;
L = 32;
v0 = 0.05;
U = 1;
tMax = 4000;
tVals = 1:1:tMax;

EtaVals = 0:0.2:1;
OrdParam = zeros(1,length(EtaVals));
for i = 1:length(EtaVals)
    eta = EtaVals(i);
    % OrdParam(i) = ExtrinsicVicsekEtaVals(N,L,v0,U,eta,tMax,tVals); % Comment to run intrinsic noise model
    OrdParam(i) = IntrinsicVicsekEtaVals(N,L,v0,U,eta,tMax,tVals); % Uncomment to run intrinsic noise model
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


data = [EtaVals; OrdParam];