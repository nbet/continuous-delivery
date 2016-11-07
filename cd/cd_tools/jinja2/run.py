#!/usr/bin/python

from jinja2 import Template
import os
import sys

def do(pname,sname,ssig=None):
  files = ['service_by_rc.sls', 'service_by_nginx.sls', 'service_by_supervisor.sls']
  for i in range(0,len(files)):
    f = open(files[i],"r")
    t = f.read()
    template = Template(t)

    homedir = os.getcwd()
    tmp = pname+'_'+ sname
    dir = homedir+'/'+tmp
    if not os.path.exists(dir):
      os.makedirs(dir)

    d = open(dir+'/init'+str(i)+'.sls','w')
    d.write(template.render(project_name=pname,service_name=sname,service_sig=ssig))
    d.close()

if __name__=='__main__':
  if len(sys.argv)==3:
      do(sys.argv[1],sys.argv[2])
  elif len(sys.argv)==4:
      do(sys.argv[1],sys.argv[2],sys.argv[3])
  else:
      print 'usage: python run.py <project_name> <service_name> [<sig>]'
      exit()

