-module(max_search).
-export([start/0]).
-import(io, [fwrite/2, fread/1]).
-import(lcg, [bsd_seed/1, bsd_rand/0]).

% write function that takes a list of integers and looks for a maximum
% value in the list.  If the list is empty, return 0.  If the list is
% not empty, return the maximum value in the list.

start() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [Seed]} = io:fread("", "~d"),
    bsd_seed(Seed),
    % create a list of random numbers
    L = lists:map(fun(_) -> bsd_rand() end, lists:seq(1,N)),
    % find the maximum value in the list
    Max = lists:max(L),
    io:fwrite("~10w~c~n", [Max,9]).