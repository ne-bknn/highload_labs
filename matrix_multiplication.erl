-module(matrix_multiplication).
-export([start/0]).
-import(io, [fwrite/2, fread/1]).
-import(lcg, [bsd_seed/1, bsd_rand/0]).

transpose([[]|_]) ->
    [];
transpose(B) ->
  [lists:map(fun hd/1, B) | transpose(lists:map(fun tl/1, B))].


red(Pair, Sum) ->
    X = element(1, Pair),   %gets X
    Y = element(2, Pair),   %gets Y
    X * Y + Sum.

%% Mathematical dot product. A x B = d
%% A, B = 1-dimension vector
%% d    = scalar
dot_product(A, B) ->
    lists:foldl(fun red/2, 0, lists:zip(A, B)).


%% Exposed function. Expected result is C = A x B.
multiply(A, B) ->
    %% First transposes B, to facilitate the calculations (It's easier to fetch
    %% row than column wise).
    multiply_internal(A, transpose(B)).


%% This function does the actual multiplication, but expects the second matrix
%% to be transposed.
multiply_internal([Head | Rest], B) ->
    % multiply each row by Y
    Element = multiply_row_by_col(Head, B),

    % concatenate the result of this multiplication with the next ones
    [Element | multiply_internal(Rest, B)];

multiply_internal([], B) ->
    % concatenating and empty list to the end of a list, changes nothing.
    [].


multiply_row_by_col(Row, [Col_Head | Col_Rest]) ->
    Scalar = dot_product(Row, Col_Head),

    [Scalar | multiply_row_by_col(Row, Col_Rest)];

multiply_row_by_col(Row, []) ->
    [].

start() ->
    {ok, [N]} = io:fread("", "~d"),
    {ok, [Seed]} = io:fread("", "~d"),
    bsd_seed(Seed),

    % Generate two NxN matrices
    A = lists:map(fun(_) -> lists:map(fun(_) -> bsd_rand() end, lists:seq(1,N)) end, lists:seq(1,N)),
    B = lists:map(fun(_) -> lists:map(fun(_) -> bsd_rand() end, lists:seq(1,N)) end, lists:seq(1,N)),

    % multiply them
    C = multiply(A, B),

    % write the sorted matrix, row by row
    lists:map(fun(X) -> lists:map(fun(Y) -> io:fwrite("~w~c ", [Y,9]) end, X) end, C).