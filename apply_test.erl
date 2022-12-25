-module(apply_test).
-export([start/0]).

% define fun F1 to add two numbers

start() ->
    F1 = fun(X, Y) -> X + Y end,
    Res = apply(F1, [1, 2]),
    io:fwrite("~w~n", [Res]).