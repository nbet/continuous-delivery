#!/usr/bin/python
import sys
import os,urllib
import tarfile

def do(repo_addr,b_ver,environment,name):

  uname=name.upper()
  path=r'/srv/%s/files/bundle' %environment
  b_name=r'%s.bundle-%s.txt' %(name,b_ver)
  b_file=os.path.join(path,b_name)
  if not os.path.exists(b_file):
      print '%s is not exist' %b_name
      exit()

  for line in open(b_file):
      str=line.replace('\n','')
      str1=str.replace('.jar','.tar.gz')
      str2=str1.replace('.war','.tar.gz')
      if ".tar.gz" not in str2:
          continue
      c_name=str2.replace('.tar.gz','-config.tar.gz')
      url="http://%s/%s/config/%s" %(repo_addr,uname,c_name)

      path=r'/srv/%s/files/config' %environment
      c_name2=c_name.replace('.tar.gz','')  
      c_dir=os.path.join(path,c_name2)
      if not os.path.exists(c_dir):
          os.makedirs(c_dir)

      c_file=os.path.join(path,c_name)
      try:
          urllib.urlretrieve(url,c_file)
      except:
          print '\tError retrieving the URL:', url 

      t=tarfile.open(c_file)
      t.extractall(c_dir)
      t.close()
  
if __name__=='__main__':
  if len(sys.argv)!=5:
      print 'number of parameter is not correct %d' %len(sys.argv)
      exit()
  do(sys.argv[1],sys.argv[2],sys.argv[3],sys.argv[4])

