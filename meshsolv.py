import subprocess as sp
import shlex
def meshgen():
    command = ['pointwise','-b','/home/neelappagouda/PROJECT/final/template.glf']
    sp.call(command)
    return()

def solver():
    command = ['SU2_CFD','/home/neelappagouda/PROJECT/final/SU2_solution/config_template.cfg']
    sp.call(command)
    return()
