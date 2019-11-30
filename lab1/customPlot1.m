function state = customPlot1(~,state,flag)

switch flag
    case 'init'
        hold on;
        x = 0:0.01:10;
        y = (1.1.*x - 1.7) .* cos(pi .* x + 1.5);        
        plot(x,y);
        
        xlabel('x');
        ylabel('F(x)');
        
        plot_ = plot(NaN,NaN,'o');
        set(plot_,'Tag','plot_');
        
        title('Graphic with current population')
    case 'iter'         
        plot_ = findobj(get(gca,'Children'),'Tag','plot_');
        set(plot_,'Xdata', NaN , 'Ydata', NaN);
        
        best = min(state.Score);
        bestX = NaN;
        
        for i = 1:size(state.Population,1)
            newX = [get(plot_,'Xdata') state.Population(i)];
            newY = [get(plot_,'Ydata') state.Score(i)];
            set(plot_,'Xdata', newX , 'Ydata', newY);
            
            if state.Score(i)==best
                bestX = state.Population(i);
            end
        end
        
        set(get(gca,'Title'),'String',sprintf('F(x): %g x: %g',best,bestX));
        
	case 'done'
        hold off;
end
