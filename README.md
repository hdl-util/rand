# rand

[![Build Status](https://travis-ci.com/hdl-util/rand.svg?branch=master)](https://travis-ci.com/hdl-util/rand)

SystemVerilog code for arbitrary width random number utilities.

## Why?

Needed an arbitrary width LFSR implementation. The one I've included works for 4 through 64 bits, but is easily extensible with the addition of more constants found using [mlpolygen](https://bitbucket.org/gallen/mlpolygen/src/default/).

## Usage

### LFSR

1. Take files from `src/` and add them to your own project. If you use [hdlmake](https://hdlmake.readthedocs.io/en/master/), you can add this repository itself as a remote module.
1. Other helpful modules are also available in this GitHub organization.
1. Consult the testbench in `test/xorshift_tb.sv` for example usage.
1. Read through the parameter descriptions in `xorshift.sv` and tailor any instantiations to your situation.
1. Please create an issue if you run into a problem or have any questions.

## To-do List

* [x] [Xorshift](https://en.wikipedia.org/wiki/Xorshift) (LFSR)
* [ ] [CBRNG](https://en.wikipedia.org/wiki/Counter-based_random_number_generator_(CBRNG)#Squares_RNG)
  * Making Squares RNG arbitrary width seems non-trivial, unfortunately
* More upon request
