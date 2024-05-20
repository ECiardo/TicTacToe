% coding challenge: program a playable version of tris, and then include an
% algorithm that plays as an opponent

% Emanuele Ciardo
% 18th of May, 2024, Donostia, Spain

% tabula rasa
clear all; close all; clc

% the history of the game will be a vector of integers from 1 to 9, which
% is the position in which the player positioned their mark. Let's
% initialize it
history = int8(zeros(1,9));

% let's visualize an example game
example = [9,8,2,5,1,6,4,3,7];
plotT(example);

%% now, let's create a human vs human game
history = zeros(1,9);
for i = 1: 9

    % who is playing?
    player = 1;
    if mod(i,2) == 0
        player = 2;
    end
    while true
        position = input(['Where do you want to place your mark, player ',num2str(player)]);
        if ismember(position,history)
            warning('the position is already occupied. Select an available one [crtl + c to leave]')
        else
            break
        end
    end

    history(i) = position;
    plotT(history)
end

%% now, let's implement the ability to know the output of a game

% I wrote the function result, let's check it
history = zeros(1,9);
plotT(history)
for i = 1: 9

    % who is playing?
    player = 1;
    if mod(i,2) == 0
        player = 2;
    end
    while true
        position = input(['Where do you want to place your mark, player ',num2str(player)]);
        if ismember(position,history)
            warning('the position is already occupied. Select an available one [crtl + c to leave]')
        else
            break
        end
    end

    history(i) = position;
    plotT(history)
    if result(history)==1
        warning('Player 1 won')
        break
    elseif result(history)==2
        warning('Player 2 won')
        break
    end
end
%% let's check how fast is it
tic 
for i = 1:10000
    result(history);
end
toc
% pretty fast

%% now, let's work on al algorithm able to play against you
% I will write a minimax algorithm at depth that can be varied to tune the
% difficulty of the computer opponent


% first, let's create a matrix of the possible games from a given starting
% position


history = [1,2,4,0,0,0,0,0,0];
plotT(history)
% this function takes care of that
depth = 9;
[possible, depth] = possible_mat(history,depth);

 % now, let's evaluate the outcome of each game
 outcome = zeros(size(possible,1),1);
 for o = 1: length(outcome)
     outcome(o) = result(possible(o,:));
 end
outcome

% now, let's apply the min-max logic to figure out the best move to play

% figure out who's turn is it
turn = 2;
if mod(find(history==0,1),2)==1
    turn = 1;
end

% figure out the turn of the last depth of the outcome
turnOut = 2;
if mod(turn+depth,2)== 1
    turnOut = 1;
end

% determine how many moves are left
move=0;
t = turnOut;
while true
    move = move+1;
    if factorial(move) == length(outcome)
        break
    end
end
move = move-1;

% now, let's calculate the best move matrix
bestM = [outcome,zeros(size(outcome,1),move)];
for m = 1: move
    win = factorial(m+1); % window
    for i = 1: size(outcome,1)/win
        tmp = 1+((i-1)*win):i*win;
        if t == 1
            bestM(tmp,m+1) = min(bestM(tmp,m));
        else
            bestM(tmp,m+1) = max(bestM(tmp,m));
        end
    end
    if t==1
        t=2;
    else
        t=1;
    end
end