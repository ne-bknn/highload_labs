-module(script).
-export([start/0]).
%-import(io, [fread/1]).
%-import(file_processor, [start/0]).
%-import(matrix_multiplication, [start/0]).
%-import(lcg, [start/0]).
%-import(max_search, [start/0]).
%-import(merge_sort, [start/0]).
%-import(trial_division, [start/0]).

not_implemented() ->
    io:fwrite("Not implemented~n").

start() ->
    {ok, [Program]} = io:fread("", "~s"),
    {ok, [Output]} = io:fread("", "~s"),

    case Program of
        "1.1" -> max_search:start(Output); % done
        "2.1" -> merge_sort:start(Output); % done
        "3.1" -> matrix_multiplication:start(Output); % done
        "4.1" -> trial_division:start(Output); % done
        "5.1" -> file_processor:start(); % done
        _ -> not_implemented()
    end.