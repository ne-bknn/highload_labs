-module(max_search).
-export([start/1]).
%-import(io, [fwrite/2, fread/1]).
%-import(lcg, [bsd_seed/1, bsd_rand/0]).

% write function that takes a list of integers and looks for a maximum
% value in the list.  If the list is empty, return 0.  If the list is
% not empty, return the maximum value in the list.

start(Output) ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [Seed]} = io:fread("", "~d"),
    lcg:bsd_seed(Seed),
    % create a list of random numbers
    L = lists:map(fun(_) -> lcg:bsd_rand() end, lists:seq(1,N)),
    % find the maximum value in the list
    {Time, Max} = timer:tc(max, [L]),
    % if output == 1, output time elapsed and primes
    % if output == 0, output only time elapsed
    case Output of
        "1" ->
            io:fwrite("time: ~w~n", [Time div 1000]),
            io:fwrite("~10w~c~n", [Max,9]);
        _ ->
            io:fwrite("time: ~w~n", [Time div 1000])
    end.