```@contents
```

# Overview
Py2Jul is a source-to-source compiler converting *procedural* Python source code
into corresponding Julia source code. As its most basic functionality, Py2Jul parses
a Python input file and translates the syntax to that of Julia's, yielding
a Julia output file. This enables the easy conversion of Python facilities to Julia
and provides an opportunity for those interested in Julia to easily test its
capabilities using previously-written Python code.

Py2Jul also offers extra capabilities in its transcompilation process on top of
simple syntax translation. First, Py2Jul interfaces the Julia file with Python
modules via the PyCall.jl library. This enable the translated Julia code to take
advantage of the modules used by the original Python source code without
having to reimplement the modules in Julia. Second, while Py2Jul uses the
PyCall.jl library for module imports, it also replaces functionalities from
specific scientific- and mathematics-oriented modules with corresponding
Julia functionalities. Modules that are replaced with Julia functionalities
include numpy, scipy, math, cmath, and random. This can be done due to Julia's
focus on scientific computing, and such translation removes the overhead that
Julia calls to Python modules has.

# Dependencies
Py2Jul has a few package dependencies that must be fulfilled. First, the PyCall
package must be installed, as Py2Jul requires PyCall to interface Julia to Python
modules. Second, the LinearAlgebra package is required, as LinearAlgebra routines
are often used as the replacement in the translation of scientific/mathematic Python
modules to Julia.

Documenter is required if you wish to view the documentation; but if you are reading
this, then you have fulfilled that dependency.

Currently, Py2Jul does not yet support the use of SnoopCompile to reduce package load
times; but this is a feature planned to be added in the future.

# Usage
To use a Python file as an input file for Py2Jul, it must first be annotated.
This is because Python uses whitespace to mark function and control flow construct
ends, while Julia uses an explicit "end" marker. The annotations account for this
issue, and they do so in such a way that still allow for the Python input file
to be run by Python. Properly annotating the Python code works as follows:

-At the end of each control flow construct (if, while, and for), "#end" must be
added.

-At the end of each function, "#endfxn" must be added.

By applying these annotations, the Python input file can be properly transcompiled
into a working Julia output file.

Once the input file has been annotated, Py2Jul can be used to translate a Python
file by using Py2Jul's translate function:

>import Py2Jul; Py2Jul.translate("path/to/input/file.py")

This will create a "path/to/input/file.jl" file. The above command can easily be run
in the REPL or in the shell, where the --eval flag can be used for the latter case.

```@meta
CurrentModule = Py2Jul
```

```@docs
Py2Jul
translate(filename_py::String)
```

# Other Notes
-Please note that Py2Jul does *not* support the transcompilation of Python
input files that use object-oriented code. As of right now, Py2Jul can
only transcompile procedural Python programs correctly. Because Julia is a
procedural language, translating classes in a reasonable manner presents a big
challenge. While concrete progress has been made on this, this functionality is
not implemented yet; and even the current idea will still require some
post-transcompilation handiwork on the user's part to yield a working
Julia output.

-Not all capabilities of the aforementioned scientific and mathematics Python
modules are yet replaced with Julia functionalities. As some of these modules
come with many functions, adding them will take time. Do note though that,
even if they are not directly replaced, functionalities from these modules will
still work via PyCall.
