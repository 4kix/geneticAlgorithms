function state = customPlot2(~,state,flag)

switch flag
    case 'init'
        hold on;        
        
        Func=@fitnessFunc2;
        xi = linspace(-2,2,100);
        yi = linspace(-2,2,100);
        [X,Y] = meshgrid(xi,yi);
        Z = Func([X(:),Y(:)]);
        Z = reshape(Z,size(X));

        contour(X,Y,Z)
        xlabel('x(1)')
        ylabel('x(2)')
        title('Func(x)')
        
        scatter_ = scatter(NaN,NaN);
        set(scatter_,'Tag','scatter_');
         
        title('Graphic with current population')
    case 'iter'   
        
         scatter_ = findobj(get(gca,'Children'),'Tag','scatter_');
         set(scatter_,'Xdata', NaN , 'Ydata', NaN);

        best = min(state.Score);
        bestX1 = NaN;
        bestX2 = NaN;

        for i = 1:size(state.Population,1)
            newX1 = [get(scatter_,'Xdata') state.Population(i,1)];
            newX2 = [get(scatter_,'Ydata') state.Population(i,2)];
            set(scatter_,'Xdata', newX1 , 'Ydata', newX2);
            
            if state.Score(i)==best
                bestX1 = state.Population(i,1);
                bestX2 = state.Population(i,2);
            end
        end
        
        set(get(gca,'Title'),'String',sprintf('F: %g      x1: %g       x2: %g',best,bestX1,bestX2));
        
	case 'done'
        hold off;
end
