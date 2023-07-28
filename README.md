# MIPS ASSEMBLY CIPHER PROGRAM

A simple cipher decryption program that decrypts strings that were encrypted with a [null chipher](https://en.wikipedia.org/wiki/Null_cipher) and then a [transposition cipher](https://en.wikipedia.org/wiki/Transposition_cipher) coded in MIPS-ASSEMBLY in order to teach myself assembly programming. Why MIPS? Because it's easier to learn due it's reduced instruction set.

> 💡 Fun fact: one of the creators of MIPS was a Master's and Phd at my university.

## Notes

Make sure you have [Valgrind](https://valgrind.org/) and [Criterion](https://criterion.readthedocs.io/en/master/setup.html) with it's required dependencies installed in order to run the unit tests.

- To install valgrind enter the following command:

    `sudo apt-get install -y valgrind`

- To install Criterion and it's dependencies enter the following command:

    `sudo apt-get install libcriterion-dev && sudo apt-get install -y ninja-build   meson cmake pkg-config libffi-dev libgit2-dev`

- Make sure you have openjdk version 11 installed. You can do this with the following command:

    `sudo apt install openjdk-11-jdk`

- Then install the required libraries:

    `sudo apt install openjdk-11-jdk --fix-missing`

- To run the unit tests enter the following:

    `make && make test`
