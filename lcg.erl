-module(lcg).
-import(io, [fread/1, fwrite/2]).

-export([bsd_seed/1, bsd_rand/0, start/0]).

bsd_seed(Seed) -> put(bsd_state, Seed).

bsd_rand() -> 
  State = (get(bsd_state) * 1103515245 + 12345) rem 2147483648,
  put(bsd_state,State),
  State.

start() -> 
  {ok, [X]} = io:fread("", "~d"),
  bsd_seed(7),
  lists:map(fun(_) -> io:fwrite("~10w~c~n", [bsd_rand(),9]) end, lists:seq(1,X)).
