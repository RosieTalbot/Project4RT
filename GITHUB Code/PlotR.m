function PlotR(times2,r,K)

plot(times2, r, 'o', 'MarkerSize', 4,'DisplayName',strcat('K = ',num2str(K)))
hold on
ylim([0,1])
xlabel('Time')
ylabel('Order Parameter Size')
title('Order Parameter Size over Time')
legend('show')
fontsize(24,"points")