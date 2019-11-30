function lab2
    panel = uipanel('FontSize',10);
    population_size = uicontrol('Parent',panel,'Style','edit','Position',[150 300 100 30],'String',50);
    uicontrol('Parent',panel,'Style','text','Position',[250 300 200 20],'String','Размер популяции');
    generations = uicontrol('Parent',panel,'Style','edit','Position',[150 260 100 30],'String',20);
    uicontrol('Parent',panel,'Style','text','Position',[250 260 200 20],'String','Кол-во поколений');
    crossover = uicontrol('Parent',panel,'Style','edit','Position',[150 220 100 30],'String',0.2);
    uicontrol('Parent',panel,'Style','text','Position',[250 220 200 20],'String','Вероятность кроссинговера');
    mutation = uicontrol('Parent',panel,'Style','edit','Position',[150 180 100 30],'String',0.2);
    uicontrol('Parent',panel,'Style','text','Position',[250 180 200 20],'String','Вероятность мутации');
    button = uicontrol('Parent',panel,'String','Построить','Position',[150 120 270 50]);

    button.Callback = @buttonCallback;
          
    function buttonCallback(~,~)
          
        FitnessFunction = @fitnessFunc2;
        numberOfVariables = 2;
        from = [-2 -2];
        to = [2 2];

        options = gaoptimset('Display', 'iter', 'PlotFcn',{@gaplotbestf, @customPlot2}, 'PopulationSize', str2double(population_size.String), ...
            'Generations', str2double(generations.String), 'CrossoverFcn', {@crossoverintermediate, str2double(crossover.String)}, ... 
            'MutationFcn', {@mutationadaptfeasible, str2double(mutation.String)});
        
        [~,~] = ga(FitnessFunction,numberOfVariables,[],[],[],[],from,to,[],[],options);
    end

end

