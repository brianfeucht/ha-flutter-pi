sudo apt update
sudo apt install git

git clone --depth 1 https://github.com/ardera/flutter-engine-binaries-for-arm.git engine-binaries
cd engine-binaries
sudo ./install.sh

sudo apt install cmake libgl1-mesa-dev libgles2-mesa-dev libegl1-mesa-dev libdrm-dev libgbm-dev ttf-mscorefonts-installer fontconfig libsystemd-dev libinput-dev libudev-dev libxkbcommon-dev
sudo fc-cache

git clone https://github.com/ardera/flutter-pi
cd flutter-pi
mkdir build && cd build
cmake ..
make -j`nproc`
sudo make install
sudo usermod -a -G render pi

sudo apt install build-essential pigpio
sudo usermod -a -G gpio pi
wget -O pwm.c https://gitlab.com/anthonydigirolamo/rpi-hardware-pwm/-/raw/master/pwm.c?inline=false
gcc -Wall -pthread -o pwm pwm.c -lpigpio -lrt
sudo cp pwm /usr/bin/pwm
sudo chmod u+s /usr/bin/pwm

sudo apt-get install jq

wget -O ~/update-app.sh https://raw.githubusercontent.com/brianfeucht/ha-flutter-pi/main/src/setup/update-app.sh
chmod 755 ~/update-app.sh
echo "*/5 * * * * /home/pi/update-app.sh" | crontab
/home/pi/update-app.sh

wget -O ~/run.sh https://raw.githubusercontent.com/brianfeucht/ha-flutter-pi/main/src/setup/run.sh
chmod 755 ~/run.sh
echo ". /home/pi/run.sh -v 2>&1 | logger &" >> /etc/profile
