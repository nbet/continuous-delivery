#!/usr/bin/python
import sys
import os
import pdb

def do(b_ver,environment,name):
  
  lname=name.lower()
  path=r'/srv/%s/files/bundle' %environment
  b_name=r'%s.bundle-%s.txt' %(lname,b_ver)
  b_file=os.path.join(path,b_name)
  if not os.path.exists(b_file):
      print '%s is not exist' %b_name
      exit()

  str='' 
  for line in open(b_file):
      f_name=line.replace('\n','')
      strlist=f_name.split('-')
      if len(strlist) != 2:
          continue
      str1=strlist[0]
      str2=strlist[1].replace('.tar.gz','')
      str3=str2.replace('.war','')
      str4=str3.replace('.jar','')
      #str+='\\'+'\"'+str1+'\\'+'\"'+': '+str2+', '
      str+='\"'+str1+'\"'+': \"'+str4+'\", '
  #print str[-2] 
  str = str[:-2]
  print str
  #return str2

if __name__=='__main__':
  if len(sys.argv)!=4:
      print 'number of parameter is not correct'
      exit()
  do(sys.argv[1],sys.argv[2],sys.argv[3])

