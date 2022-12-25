-module(trial_division).
-export([start/1]).
-import(io, [fwrite/2, fread/1]).

is_prime(0) -> false;
is_prime(1) -> false;
is_prime(2) -> true;
is_prime(3) -> true;

is_prime(N) ->
    is_prime(N, 2).

is_prime(N, D) when D * D > N -> true;
is_prime(N, D) when N rem D =:= 0 -> false;
is_prime(N, D) -> is_prime(N, D + 1).

% return list of all primes in [A, B)
process(A, B) ->
    lists:filter(fun is_prime/1, lists:seq(A, B)).

start(Output) ->
    {ok, [A]} = io:fread("", "~d"),
    {ok, [B]} = io:fread("", "~d"),

    Process = fun(A, B) -> process(A, B) end,
    {Time, Primes} = timing:tc(Process, [A, B]),

    % if output == 1, output time elapsed and primes
    % if output == 0, output only time elapsed
    case Output of
        "1" ->
            io:fwrite("time: ~w~n", [Time]),
            lists:foreach(fun(P) -> io:fwrite("~w~n", [P]) end, Primes);
        _ ->
            io:fwrite("time: ~w~n", [Time])
    end.