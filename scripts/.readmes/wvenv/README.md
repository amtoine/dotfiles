# wvenv.

## Dependencies for wvenv.
`wvenv` will not crash without these, but the output might be unpredictable.  
- `which` to know where the command is located.
- `python`, `python3` the python interpreters.
- `pip`, `pip3` the python package managers.
- `jupyter`, `jupyter-notebook` to edit and see jupyter notebooks.

Notes:
- I really highly recommend you, once you have installed python on the system, to install `virtualenv`, `pyenv`, `conda`, or similar
and NEVER intall `python` package on you system directly!
- instead, create a sane virtual environment with your prefered environment manager above and install everything in it.
- one can use multiple environments for different purposes. For instance a dedicated environment for `jupyter`
(it is a pain to uninstall from the main system), another one for machine learning stuff, and so on...
