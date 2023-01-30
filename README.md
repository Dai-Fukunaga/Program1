# CS541 Project1
"Project1" is an assignment for CS541.

## Description
This is a program for Lexical Analyzer.

## Author
Dai Fukunaga

## Date
01/30/2023

## Getting Started
### Requires
* Ubuntu 22.04.1 LTS
* flex 2.6.4
* g++ (Ubuntu 11.3.0-1ubuntu1~22.04) 11.3.0

### Executing Program
* Compile the code
```bash
make
```

* Run the program without command line arguments
```bash
./program1
```

* Run the program with a command line argument
```bash
./program1 input_file_path
```

* Delete execute programs
```bash
make clean
```

## Test Cases
There are many test cases in a `tests` directory. <br>
For example, if you want to test a "test_int_in.txt" file, run like below.
```bash
./program1 tests/test_int_in.txt
```
You can see the expected results in a "test_int_out.txt" file.

## Functions
* int main(void) <br>
This function check a command line argument. <br>
If there are no command line arguments, it handles user input.
Otherwise, it handles an input file.

* std::string token_name(int tok) <br>
This function returns a token name.

## Bugs
No bugs right now.
