
function PlotVicsekMove(r,L,N,i,v)

figure(2)
    plot(r(1:N,i+1),r(N+1:2*N,i+1),'.k','MarkerSize',15)
    %q = quiver(r(1:N,i),r(N+1:2*N,i),v(1:N,i),v(N+1:2*N,i),'k');
    %q.LineWidth = 1;

    colororder('glow12')
    xlim([0 L]);
    ylim([0 L]);
    
    axis square
    %hold on
    xlabel('')
    ylabel('')
end