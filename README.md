# AoC2019
Advent of Code 2019

I will be using Swift through the command line interface, mainly due to performance reasons.
To use Swift with the command line, open your terminal and enter:

$ xcode-select --install

After that you can run a Swift file like this:

$ swift Filename.swift

Do note that the above command runs the file as a script, which is very slow. Instead we want to compile it so it runs faster. this is done by using "swiftc" like this:

$ swiftc Filename.swift

This leaves you with an executable that can be run simply by typing "Filename". This is still not optimal so we will use the "-O" extension to optimise the compilation.

$ swiftc -O Filename.swift

This compilation takes a little longer but the result is much faster. For example, a bit of code that adds together the numbers 1 to 100,000,000 takes 2 minutes on my Macbook 2012 Pro with the regular compilation but less that 1 second with the optimised compilation.
