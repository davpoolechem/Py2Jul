# Welcome to Py2Jul!
Py2Jul is a program that allows you to convert your procedural Python programs into Julia programs to gain the extra performance that Julia offers.

# Features
-Convert procedural Python scripts into Julia scripts automatically

-Supports use of Python modules; PyCall.jl is used to natively call Python modules from the Julia code

-Supports use of math, cmath, and NumPy; functionalities from these modules are converted into corresponding Julia functionalities

# Usage
First, on its own, Py2Jul.jl does not yield a complete, working Julia file. This is because Python uses whitespace to mark function and control flow construct ends, while Julia uses an explicit "end" marker. This must be accounted for. 

*However*, Py2Jul supports the use of annotations in translated .py files, that enable the handling of such construct issues without affecting the .py file's ability to be run in the Python interpreter. Specifically, this can be handled by adding the "#end" annotation at the end of each control flow construct (if, while, and for) and the "#endfxn" annotation to each function definition in the .py file. Doing this will allow Py2Jul to yield a complete, working Julia file.

Second, once the annotations are added, a .jl file can be created from a .py file via Py2Jul by running the command 

'julia py2jul.jl path/to/python/file.py'

in the shell. This converts file.py to file.jl. 

# Issues

-Conversion of Python programs with classes is not yet supported, as Python is object-oriented and Julia is procedural. This feature will not be added until I find a method of translation of classes that I am happy with.

-Py2Jul is basically in a pre-alpha stage. This leaves quite a few things on the TODO list, as discussed below.

# TODO
-Find a good way to translate classes into a procedural fashion.

-Continue with adding function from the NumPy list to be translated into Julia functionalities.