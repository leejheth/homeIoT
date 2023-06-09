# homeIoT
Home IoT data collection and upload.

Collect CO2, humidity, temperature data using Sensirion SCD41 sensor and upload the data to AWS RDS database (MySQL engine). This is containerized (Docker) and run on Raspberry Pi B+ model (32bit, ARMv6 CPU). Interactive visualization of data on R Shiny app.

This repository is under development and more features will follow.

## Installation
### Development
Prerequisite: [conda](https://docs.conda.io/projects/conda/en/stable/user-guide/install/index.html)
Clone the repository to your work directory.
```
git clone git@github.com:leejheth/homeIoT.git
cd homeIoT
```

Set up the environment. This will create a new conda environment and install all dependencies in it.
```
make setup
```

Activate the newly create environment.
```
conda activate iot-env
```

Start measurement and data streaming.
```
python measure.py
```

### Run Docker image on Raspberry Pi
* [Install](https://www.raspberrypi.com/software/) Raspberry Pi OS Lite on micro SD card on your PC and insert the card to Raspberry Pi. In advanced setting, configure WLAN credentials and enable ssh connection.
* Set [static IP address](https://www.makeuseof.com/raspberry-pi-set-static-ip/) on your Raspberry Pi, so it is always accessible via ssh connection with the same private IP address.
* Install Docker
```
sudo apt-get update
sudo apt-get upgrade
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh
```
Verify if the docker installation is successful using the following command.
```
docker run hello-world
```

Pull docker image from Docker Hub.
```
docker image pull leejih/pi-co2-sensor:3.1
```

In your current directory, create a folder named conf and a file named 'mysql.txt' to store MySQL-related credentials.
```
mkdir conf
touch conf/mysql.txt
```

Run docker container.
```
docker run --mount type=bind,source="$(pwd)"/conf,target=/home/conf --device=/dev/ttyUSB0 -d here_comes_image_ID
```

## References
* [SCD4x CO2 sensors](https://developer.sensirion.com/sensirion-products/scd4x-co2-sensors/)
* [Amazon RDS](https://aws.amazon.com/rds/)
