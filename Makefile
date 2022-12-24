.PHONY: all
all: lcg.beam max_search.beam merge_sort.beam matrix_multiplication.beam trial_division.beam file_processor.beam

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

clean:
	-@rm *.beam
