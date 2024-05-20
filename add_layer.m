function x = add_layer(input)

     pos = find(input==0,1);

    % find the numbers to add
    to_add = setdiff(1:9,input);
    x = zeros(length(to_add),9);
    for n = 1: length(to_add)
        x(n,:)   = [input(1:(pos-1)),to_add(n),zeros(1,9-pos)];
    end
end
