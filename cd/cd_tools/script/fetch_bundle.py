#!/usr/bin/python
import sys
import os,urllib

def do(repo_addr,b_ver,environment,name):

  path=r'/srv/%s/files/bundle' %environment
  if not os.path.exists(path):
      os.makedirs(path)

  uname=name.upper()
  f_name=r'%s.bundle-%s.txt' %(name,b_ver)
  dest_dir=os.path.join(path,f_name)

  url="http://%s/%s/bundles/%s" %(repo_addr,uname,f_name)
  try:
      urllib.urlretrieve(url,dest_dir)
  except:
      print '\tError retrieving the URL:', dest_dir

if __name__=='__main__':
  if len(sys.argv)!=5:
      print 'number of parameter is not correct %d' %len(sys.argv)
      exit()
  do(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])

