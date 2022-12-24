#!/bin/bash

erl -noshell -s "$1" start -s init stop
