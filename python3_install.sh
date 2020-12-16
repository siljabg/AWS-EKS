##Python 3 for centos
#add / in secure_path part in sudoers
#sudo vim /etc/sudoers
sudo su -
yum update -y
yum groupinstall -y "development tools"
yum install -y \
  libffi-devel \
  zlib-devel \
  bzip2-devel \
  openssl-devel \
  ncurses-devel \
  sqlite-devel \
  readline-devel \
  tk-devel \
  gdbm-devel \
  db4-devel \
  libpcap-devel \
  xz-devel \
  expat-devel \
  gcc \
  git
 
curl -O https://www.python.org/ftp/python/3.9.1/Python-3.9.1.tgz
tar -xzf Python-3.9.1.tgz
cd Python-3.9.1/
./configure --enable-optimizations
make altinstall
exit
python3.9
sudo pip3.9 install --upgrade pip
git config --global user.name "Dragan Siljanovski"
git config --global user.mail "dragan.siljanovski@gmail.com"
##check whether pip is installed
#python -m pip --version
pip3.9 list #to check installed package
sudo pip3.9 install boto3
pip3.9 freeze > requirements.txt
sudo pip3.9 uninstall -y -r requirements.txt
sudo pip3.9 install -r requirements.txt #put them in another directory

#python virtualenv
mkdir venvs
python3.9 -m venv venvs/experiment
ls venvs/experiment/
source venvs/experiment/bin/activate
which python
python --version
pip list
deactivate 
