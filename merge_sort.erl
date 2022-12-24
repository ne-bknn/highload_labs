-module(merge_sort).
-export([start/0]).
-import(io, [fwrite/2, fread/1]).
-import(lcg, [bsd_seed/1, bsd_rand/0]).

msort([]) -> [];
msort([H]) ->
    [H];
msort(List) ->
    {Front, Back} = split(List),
    merge(msort(Front), msort(Back)).

split(List) ->
    split(List, List, []).
split([], Back, Front) ->
    {lists:reverse(Front), Back};
split([_], Back, Front) ->
    {lists:reverse(Front), Back};
split([_,_ | Counter], [H | T], Result) ->
    split(Counter, T, [H | Result]).
 
merge([], Back) ->
    Back;
merge(Front, []) ->
    Front;
merge([L | Front], [R | Back]) when L < R ->
    [L | merge(Front, [R | Back])];
merge([L | Front], [R | Back]) ->
    [R | merge([L | Front], Back)].

start() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [Seed]} = io:fread("", "~d"),
    bsd_seed(Seed),
    % create a list of random numbers
    L = lists:map(fun(_) -> bsd_rand() end, lists:seq(1,N)),
    % find the maximum value in the list
    Sorted = msort(L),
    % write the sorted list 
    lists:map(fun(X) -> io:fwrite("~10w~c ", [X,9]) end, Sorted).