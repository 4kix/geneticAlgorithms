function [results] = tspread( filename )
%TSPREAD - Reads a file in .tsp format containing data for traveling
%salesperson data.
%
%INPUT: The name of a file in .tsp format. 
%       For a full specification of the tsp format see
%       http://comopt.ifi.uni-heidelberg.de/software/TSPLIB95/DOC.PS
%
%OUTPUT: A key-value-map containing all parsed data.
%
%NOTE: Due to laziness only the specification part and coordinates are
%      parsed. Feel free to extend this function to also parse other
%      types of data sections.
%
% Example file:
% ---------------------------------------------------
% |   NAME : EXAMPLE                                |
% |   COMMENT : THIS IS AN EXAMPLE FOR A TSP FILE   |
% |   TYPE : TSP                                    |
% |   DIMENSION : 3                                 |
% |   EDGE_WEIGHT_TYPE : EUC_2D                     |
% |   NODE_COORD_SECTION                            |
% |   1  1000 300                                   |
% |   2  1000 600                                   |
% |   3  1000 900                                   |
% |   EOF                                           |
% ---------------------------------------------------


%------------- BEGIN CODE --------------
%Possible keywords in the specification section
spec_keywords = [{'NAME'},{'TYPE'},{'COMMENT'},{'DIMENSION'},...
                 {'CAPACITY'},{'EDGE_WEIGHT_TYPE'},{'EDGE_WEIGHT_FORMAT'},...
                 {'EDGE_DATA_FORMAT'},{'NODE_COORD_TYPE'},{'DISPLAY_DATA_TYPE'}];

%Possible data section keywords - ONLY NODE_COORD_SECTION WORKS FOR NOW.
section_keywords = [{'NODE_COORD_SECTION'}, {'DEPOT_SECTION'}, ...
                    {'DEMAND_SECTION'}, {'EDGE_DATA_SECTION'}, ...
                    {'FIXED_EDGES_SECTION'}, {'DISPLAY_DATA_SECTION'},...
                    {'TOUR_SECTION'}, {'EDGE_WEIGHT_SECTION'}];

%A regex to match 2D coord data
coords_regex = '([0-9]+) +(([0-9]+).?[0-9]*) +(([0-9]+).?[0-9]*)';
%Initialize data structures
results = containers.Map;             
coordinates = [];             
spec_found = true;

%read the input file
fid = fopen(filename);
%read the first line
line = fgetl(fid);

%First scan the specification part
while(ischar(line) && spec_found)
    spec_found = false;
    %Test every specification keyword for the current line
    for k = spec_keywords
        %construct a regex for the keyword
        regex = strcat('\s*',k,'\s*:\s*(\S*)');
        %match the current line against the regex
        position = regexp(line, regex, 'tokens');
        %if the match was successful
        if size(position{1}) > 0
            %add the keyword and the value to the results map
            results(k{1}) = char(position{1}{1});
            spec_found = true;
        end
    end
   line = fgetl(fid);
end 

%Scan the rest of the file for 2D-coordinates
while(ischar(line))
    position = regexp(line, coords_regex, 'tokens');
    if (size(position) > 0)
       x = (position{1}(2));
       y = (position{1}(3));
       x = strread((x{1}), '%f');
       y = strread((y{1}), '%f');
       coordinates = [coordinates; [x,y]];
    end
    line = fgetl(fid);
end
results('COORDINATES') = coordinates;
end
%------------- END OF CODE --------------
