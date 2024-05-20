function x = result(history)

for k = 1: 5 % the while arch is to account for multiple winning patterns
    comb = [1,2,3;
            4,5,6;
            7,8,9;
            1,4,7;
            2,5,8;
            3,6,9;
            1,5,9;
            3,5,7];
    x = 0; % initialize to no winner
    pl1 = false;
    pl2 = false;
    % check if player 1 won
    focus = history([1,3,5,7,9]);
    for i =1: size(comb,1)
        if all(ismember(comb(i,:),focus))
            pl1 = true;
            break
        end
    end
    
    % check if player 2 won
    focus = history([2,4,6,8]);
    for i =1: size(comb,1)
        if all(ismember(comb(i,:),focus))
            pl2 = true;
            break
        end
    end

    % end only if there is only one winning pattern
    if ~(pl2 == true & pl1 == true)
        if pl1
            x = -1;
        elseif pl2
            x = 1;
        end
        break
    else
        index = find(history==0);
        if isempty(index)
            index = 9;
        end
        history(index-1) = 0;
    end
end

