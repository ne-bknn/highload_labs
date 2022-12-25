-module(file_processor).
-export([start/0]).
%-import(io, [fread/1]).
%-import(file, [open/2, close/1, read/2, write/2]).

alternate(List) ->
    evens(List).

evens([_|T]) ->
    odds(T);
evens([]) -> [].

odds([H|T]) ->
    [H | evens(T)];
odds([]) -> [].

process(Input) ->
    % read the input file
    {ok, Bin} = file:read_file(Input),
    % open input file for writing
    {ok, In} = file:open("input", [write]),
    % convert Bin to a list
    List = binary_to_list(Bin),
    AlternatingList = alternate(List),
    % write every second element of the list to In
    file:write(In, AlternatingList),
    % write the whole Bin to In
    file:write(In, Bin),
    % close the input file
    file:close(In).

start() ->
    % read file name from the standard input
    {ok, [Input]} = io:fread("", "~s"),
    {Time, _} = timer:tc(process, [Input]),
    % write the time in milliseconds to the standard output
    % remember that Time is in microseconds
    % format is "time: 100" without decimals
    io:fwrite("time: ~w~n", [Time div 1000]).