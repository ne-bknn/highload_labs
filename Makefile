TASKS = lcg max_search merge_sort matrix_multiplication trial_division file_processor script timing

BEAMS = $(addsuffix .beam, $(TASKS))

.PHONY: default
default: $(BEAMS)

lcg.beam: lcg.erl
	erlc $^

max_search.beam: max_search.erl
	erlc $^

merge_sort.beam: merge_sort.erl
	erlc $^

matrix_multiplication.beam: matrix_multiplication.erl
	erlc $^

trial_division.beam: trial_division.erl
	erlc $^

file_processor.beam: file_processor.erl
	erlc $^

script.beam: script.erl
	erlc $^

timing.beam: timing.erl
	erlc $^

clean:
	-@rm *.beam
