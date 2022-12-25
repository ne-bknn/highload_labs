-module(timing).
-export([tc/2, tc/3]).

tc(F, A) ->
    T1 = erlang:monotonic_time(),
    Val = apply(F, A),
    T2 = erlang:monotonic_time(),
    Time = erlang:convert_time_unit(T2 - T1, native, millisecond),
    {Time, Val}.

tc(M, F, A) ->
    T1 = erlang:monotonic_time(),
    Val = apply(M, F, A),
    T2 = erlang:monotonic_time(),
    Time = erlang:convert_time_unit(T2 - T1, native, microsecond),
    {Time, Val}.