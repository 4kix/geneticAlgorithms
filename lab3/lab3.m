function lab3

    result = tspread('pr76.tsp');

    panel = uipanel('FontSize',12);
    
    uicontrol('Parent',panel,'Style','text','Position',[10 390 150 20],'String',sprintf('Файл: %s',result('NAME')));
    
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
          
        coordinates = result('COORDINATES');
        populations_ = str2double(population_size.String);
        generations_ = str2double(generations.String);
        crossover_ = str2double(crossover.String);
        mutation_ = str2double(mutation.String);
        
        tsp_genetic_algo(coordinates, populations_, generations_, crossover_, mutation_);
       
    end

end

