vagrant-otrs
============

Vagrant Box with OTRS 6.6 centos/7 

git clone git@github.com:mark3l/otrs-vagrant.git
cd otrs-vagrant

1. Run "vagrant up" (If you have an old installation, run "vagrant destroy" previously)
2. Go to the OTRS installer at http://localhost:3002/otrs/installer.pl
3. DB usr:root pass:otrs-ioa
4. (Optional) Configure Mail settings
5. Remember OTRS-root user password for first login
6. Login at `http://localhost:3002/otrs/index.pl`

#### OTRS install directory
```
/opt/otrs
```

### OTRS Share directory

If you need a share directory run: 

1. vagrant plugin install vagrant-vbguest
2. vagrant vguest

```
3 - uncomment setting in Vagrantfile
```

#### OTRS Version
Default version is 6.0.6
Setting in init.sh file 

