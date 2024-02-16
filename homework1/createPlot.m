function createPlot(vect)
    
    % Making plot variables
    start  = vect.duration(1);
    finish = vect.duration(2);
    length = vect.length;
    data = vect.data;
    
    n = linspace(start, finish, length);
    
    % Plotting
    figure;
    stem(n, data);
    xlim([start-1,start+length]);
    xticks(start-1:start+length);
    if min(data) >= 0
        ylim([0,max(data)+1]);
    else
        yline([min(data)-1, max(data)+1]);
    end

    xlabel('n');
    title('Stem Plot');
end
