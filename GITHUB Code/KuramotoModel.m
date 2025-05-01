% Kuramoto Model

%% Variables


N = 500; % Number of particles
K = 1.7;
dt = 0.01;
times1 = 0:0.01:1000;
times2 =  0:dt:100;

omega = randn(1,N); % Natural frequency of particles
th = 0:pi/50:2*pi;
% figure(8)
% histogram(omega,50)

% A is the matrix of the coupling values
A = rand(N)>0.1; A = A+A'; A(A ~=0) = 1;  A = A/N;
A = A*K;
%A = 20*ones(N,N);

%% ODE

[~,Us] = ode45(@(t,U) RHS(U,A,omega,N), times1, mod(2*pi*rand(1,N),2*pi));
[T,U] = ode45(@(t,U) RHS(U,A,omega,N), times2, Us(end,:));
M = mod(U,2*pi);

LastU = M(length(times2),:);
LastT = T(length(times2),:);

SMany = sin(U);
CMany = cos(U);

S = sin(LastU);
C = cos(LastU);

ordparam = 1/N*sum(exp(1i*M'));
firstordparam = 1/N*sum(exp(1i*M(1,:)));
lastordparam = 1/N*sum(exp(1i*M(length(times2),:)));

% r = sqrt((real(ordparam)).^2+(imag(ordparam)).^2);

r = abs(ordparam);
psi = atan2(imag(ordparam),real(ordparam));

x = real(lastordparam);
y = imag(lastordparam);

% drdt = zeros(1,length(times2));
% for i = 1:length(times2)-1
%     dr = r(i) - r(i+1);
%     drdt(i) = dr/dt;
% end

%% plotting
% figure(1);
% hold on;
% plot(T,M,'.','MarkerSize',5)
% xlabel('Time')
% ylabel('Omega')
% title('Phase against Time')
% fontsize(24,"points")

figure(2);
hold on;
plot(cos(th),sin(th),'-','LineWidth', 4,'Color', [0.6350 0.0780 0.1840])
p = plot(C,S,'ob','MarkerSize',10);
p.MarkerFaceColor = [0 0 1];
quiver(0,0,x,y,0,'.m','LineWidth',2)
plot(0,0,'.k','MarkerSize',30)
plot(x,y,'.m','MarkerSize',40)
axis square
xlim([-1,1])
ylim([-1,1])
legend('Unit Circle','Particles','','Origin','OrderParameter')
fontsize(24,"points")


figure(3);
hold on
plot(times2, r,'.', 'MarkerSize',12,'DisplayName',strcat('K = ',num2str(K)))
ylim([0,1])
xlabel('Time')
ylabel('Order Parameter Size')
legend('show')
fontsize(24,"points")

figure(4);
h = histogram(LastU,30)
xlabel('Phase')
ylabel('Frequency')
xlim([0,2*pi])
fontsize(24,"points")
hold on

% figure(5);
% plot(times2,drdt)

%% displaying stuff
disp(['The initial r is: ',num2str(sqrt((real(firstordparam)).^2+(imag(firstordparam)).^2))])
disp(['The final r is: ', num2str(sqrt((real(lastordparam)).^2+(imag(lastordparam)).^2))])

%% du = change in theta
function du = RHS(theta,A,omega,N)
du = zeros(N,1);
for i = 1:N
    %keyboard;
    du(i) = omega(i) + A(i,:)*sin(theta-theta(i));
end

end













