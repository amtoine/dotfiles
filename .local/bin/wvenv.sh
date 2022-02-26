#! /usr/bin/bash
#           ___                       personal page: https://a2n-s.github.io/
#      __ _|_  )_ _    ___   ___      github   page: https://github.com/a2n-s
#     / _` |/ /| ' \  |___| (_-<      my   dotfiles: https://github.com/a2n-s/dotfiles
#     \__,_/___|_||_|       /__/
#             __                              _
#      ___   / / __ __ ____ _____ _ ___ __ __| |_
#     (_-<  / /  \ V  V /\ V / -_) ' \ V /(_-< ' \
#     /__/ /_/    \_/\_/  \_/\___|_||_\_(_)__/_||_|
#
# Description:  prints some information about the current virtual
#               python environment running.
#               an example when not inside a virtual environment.
#                     command |                    path (version)
#                    ---------+-------------------------------------------------------
#                     python  | /usr/bin/python (Python 3.9.9)
#                        pip  | /usr/bin/pip (pip 20.3.4)
#                    python3  | /usr/bin/python3 (Python 3.9.9)
#                       pip3  | /usr/bin/pip3 (pip 20.3.4)
#                    jupyter  | --
#                    notebook | -- (--)
#
#               an example when inside a virtual environement, with jupyter installed.
#                     command |                    path (version)
#                    ---------+-------------------------------------------------------
#                     python  | /home/ants/.venvs/ml/bin/python (Python 3.9.9)
#                        pip  | /home/ants/.venvs/ml/bin/pip (pip 21.3.1)
#                    python3  | /home/ants/.venvs/ml/bin/python3 (Python 3.9.9)
#                       pip3  | /home/ants/.venvs/ml/bin/pip3 (pip 21.3.1)
#                    jupyter  | /home/ants/.venvs/ml/bin/jupyter
#                    notebook | /home/ants/.venvs/ml/bin/jupyter-notebook (6.4.6)
# Dependencies: python, pip, and jupyter, jupyter-notebook to have full information but required.
# License:      https://github.com/a2n-s/dotfiles/blob/main/LICENSE 
# Contributors: Stevan Antoine

if command -v python &> /dev/null; then
    PY=$(which python)
    PYV=$(python --version)
fi
if command -v pip &> /dev/null; then
    PIP=$(which pip)
    PIPV=$(pip --version | cut -d' ' -f1-2)
fi
if command -v python3 &> /dev/null; then
    PY3=$(which python3)
    PIP3=$(which pip3)
fi
if command -v pip3 &> /dev/null; then
    PY3V=$(python3 --version)
    PIP3V=$(pip3 --version | cut -d' ' -f1-2)
fi
JPT="--"
if command -v jupyter &> /dev/null; then
    JPT=$(which jupyter)
fi
NB="--"
NBV="--"
if command -v jupyter-notebook &> /dev/null; then
    NB=$(which jupyter-notebook)
    NBV=$(jupyter-notebook --version)
fi



echo " command |                    path (version)"
echo "---------+-------------------------------------------------------"
echo " python  | $PY ($PYV)"
echo "    pip  | $PIP ($PIPV)"
echo "python3  | $PY3 ($PY3V)"
echo "   pip3  | $PIP3 ($PIP3V)"
echo "jupyter  | $JPT"
echo "notebook | $NB ($NBV)"
