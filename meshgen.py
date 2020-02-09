import subprocess as sp
import shlex
def meshgen():
    command = ['pointwise','-b','/home/neelappagouda/PROJECT/python_code/template.glf']
    sp.call(command)
    return()
