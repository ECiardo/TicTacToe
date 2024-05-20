function [possible, depth] = possible_mat(possible, depth)
    first = find(possible(1,:) == 0, 1); % find the position of first zero
    initial_rows = size(possible, 1);
    possible_size = (10 - first) * initial_rows;
    
    % Preallocate the size of the new matrix for the first iteration
    new = zeros(possible_size, 9);
    count = 0;
    for d = 1:depth
        % transform the possible matrix in the updated one, with added depth
        start = 1;
        count = count+1;
        for p = 1:initial_rows % loop through the possible rows
            % Perform the add_layer transformation
            layer_output = add_layer(possible(p,:));
            
            % Determine where to store the output
            end_idx = start + size(layer_output, 1) - 1;
            new(start:end_idx, :) = layer_output;
            start = end_idx + 1;
        end
        
        % Update possible with new values and update initial_rows
        possible = new(1:end_idx, :);
        initial_rows = size(possible, 1);
        
        % Break if you reached the bottom
        if possible(1, 9) ~= 0
            break
        end
        
        % Preallocate the size of the new matrix for the next iteration
        first = find(possible(1,:) == 0, 1);
        if isempty(first)
            first = 10; % If there are no zeros, set first to 10
        end
        possible_size = (10 - first) * initial_rows;
        new = zeros(possible_size, 9);
    end
    depth = count;
end
