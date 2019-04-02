# Py2Jul
Convert your Python programs into Julia programs to gain the extra performance that Julia offers, for free!

# Features
-Convert procedural Python scripts into Julia scripts automatically
-Use of Python modules is handled via PyCall.jl
-NumPy functionalities are converted into Julia functionalities

# Usage
Run the command 

'julia py2jul.jl path/to/python/file'

This converts file.py to file.jl. Note that this does not yet yield a complete file, as explained below.

# Issues
This is basically still in alpha, so almost everything is actively being developed. If you run into issues, let me know! Some more notable issues are as follows:

-Running this script does not yet yield a complete file. This is because Python uses whitespace to mark function and control flow construct ends, while Julia uses an explicit "end" marker. These explicit end markers must be added to the end of each control flow construct and function in the Julia program to yield a complete, working.

-Conversion of Python programs with classes is not yet supported, and will not be supported until I find a reasonable way to inline Python functions via script.

-NumPy translation is still a work in progress.
