-module(merge_sort).
-export([start/1]).
% -import(io, [fwrite/2, fread/1]).
% -import(lcg, [bsd_seed/1, bsd_rand/0]).

tc(F, A) ->
    T1 = erlang:monotonic_time(),
    Val = apply(F, A),
    % timer:sleep(1000),
    T2 = erlang:monotonic_time(),
    Time = erlang:convert_time_unit(T2 - T1, native, microsecond),
    {Time, Val}.

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

start(Output) ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [Seed]} = io:fread("", "~d"),
    lcg:bsd_seed(Seed),
    % create a list of random numbers
    L = lists:map(fun(_) -> lcg:bsd_rand() end, lists:seq(1,N)),
    % sort the list, time it
    Msort = fun(L) -> msort(L) end,
    {Time, Sorted} = tc(Msort, [L]),
    % if output == 1, output time elapsed and primes
    % if output == 0, output only time elapsed
    case Output of
        "1" ->
            io:fwrite("time: ~B~n", [Time]),
            lists:map(fun(X) -> io:fwrite("~10w~c ", [X,9]) end, Sorted);
        _ ->
            io:fwrite("time: ~w~n", [Time div 1000])
    end.