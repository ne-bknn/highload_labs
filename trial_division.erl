-module(trial_division).
-export([start/0]).
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

start() ->
    {ok, [A]} = io:fread("", "~d"),
    {ok, [B]} = io:fread("", "~d"),

    % print all primes between in [A, B)
    lists:map(fun(X) -> io:fwrite("~10w~c~n", [X,9]) end, 
              lists:filter(fun is_prime/1, lists:seq(A, B))).
