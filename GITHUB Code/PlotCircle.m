function PlotCircle(ordparam,U)
th = 0:pi/50:2*pi;
S = sin(U);
C = cos(U);

x = real(ordparam);
y = imag(ordparam);

p1 = plot(cos(th),sin(th),'-','LineWidth', 3, 'Color', [0.6350 0.0780 0.1840]);
hold on
p = plot(C,S,'ob','MarkerSize',10);
p.MarkerFaceColor = [0 0 1];
quiver(0,0,x,y,0,'.m')
plot(0,0,'.k','MarkerSize',30)
plot(x,y,'.m','MarkerSize',40)
axis square
xlim([-1,1])
ylim([-1,1])
title('Particles Plotted on the Unit Circle')
legend('Particles','Unit Circle','','Origin','OrderParameter')
legend('off')
fontsize(24,"points")
end