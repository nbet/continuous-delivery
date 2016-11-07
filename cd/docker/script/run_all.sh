docker run  -d  --name="test_salt_foreman" -v /opt/data/test_salt:/srv -p 14506:4506 -p 8080:80 -p 9443:8443 -p 1443:443 -p 14505:14505 --env pub_port=14505 centos66_salt_foreman

