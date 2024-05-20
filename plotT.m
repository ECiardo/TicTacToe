function plot_tictactoe(x)
    % Check if the input is valid
    if length(x) ~= 9 || any(x < 0) || any(x > 9)
        error('Input must be a list of 9 numbers between 0 and 9.');
    end
    
    % Initialize the figure
    close all
    figure;
    hold on;
    axis([0 3 0 3]);
    axis off;
    set(gca, 'XTick', [], 'YTick', []);
    
    % Draw the grid lines
    for i = 1:2
        plot([i i], [0 3], 'k', 'LineWidth', 2);
        plot([0 3], [i i], 'k', 'LineWidth', 2);
    end
    
    % Plot Xs and Os based on the input
    for i = 1:9
        pos = x(i);
        if pos == 0
            continue;
        end
        row = 3 - floor((pos - 1) / 3);
        col = mod(pos - 1, 3) + 1;
        if mod(i, 2) == 1
            % Plot X for odd indices
            plot(col-0.5, row-0.5, 'x', 'Color', 'r', 'LineWidth', 2, 'MarkerSize', 30);
        else
            % Plot O for even indices
            plot(col-0.5, row-0.5, 'o', 'Color', 'b', 'LineWidth', 2, 'MarkerSize', 30);
        end
    end
    
    hold off;
end

