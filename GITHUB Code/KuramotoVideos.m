% Produces Kuramoto model Simulations

%% Variables

N = 100; % Number of particles
K = 5; % Coupling strength 
dt = 0.05;
times1 = 0:0.01:100;
times2 =  0:dt:20;
omega = randn(1,N);

% A is the matrix of the coupling values
A = rand(N)>0.1; A = A+A'; A(A ~=0) = 1;  A = A/N;
A = A*K;

%% ODE
[~,Us] = ode45(@(t,U) RHS(U,A,omega,N), times1, mod(rand(1,N)*2*pi,2*pi));
[T,U] = ode45(@(t,U) RHS(U,A,omega,N), times2, Us(end,:));
M = mod(U,2*pi);

LastU = M(length(times2),:);
LastT = T(length(times2),:);

SMany = sin(U);
CMany = cos(U);

ordparam = 1/N*sum(exp(1i*M'));
firstordparam = 1/N*sum(exp(1i*M(1,:)));
lastordparam = 1/N*sum(exp(1i*M(length(times2),:)));

r = abs(ordparam);
psi = atan2(imag(ordparam),real(ordparam));


%% Moving circle plot
close all
v = VideoWriter("OpKuramotoK5N100.mp4",'MPEG-4');
open(v)
for i = 1:length(times2)
    PlotCircle(ordparam(i),M(i,:))
    pause(0.05)
    hold off
    frame = getframe(gcf);
    writeVideo(v,frame)
end
close(v)

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