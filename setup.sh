#!/bin/bash
set -e

#
# Microsoft IE/Edge VMs
# https://developer.microsoft.com/en-us/microsoft-edge/tools/vms/
#
# Microsoft Edge on Win10 (x64) Stable (14.14393)
#
wget --directory-prefix=tmp https://az792536.vo.msecnd.net/vms/VMBuild_20160810/Vagrant/MSEdge/MSEdge.Win10_RS1.Vagrant.zip \
&& 7za -otmp x tmp/MSEdge.Win10_RS1.Vagrant.zip \
&& vagrant box add tmp/dev-msedge.box --name "Win10_Edge"

#
# Microsoft Web Driver
# https://developer.microsoft.com/en-us/microsoft-edge/tools/webdriver/
#
# Release 14393 (Version: 3.14393 | Edge version supported: 14.14393)
#
wget --directory-prefix=tmp https://download.microsoft.com/download/3/2/D/32D3E464-F2EF-490F-841B-05D53C848D15/MicrosoftWebDriver.exe

#
# Java Runtime Environment
#
# Version 8u131 (for Windows x64)
#
wget --directory-prefix=tmp --no-check-certificate --no-cookies \
  --header "Cookie: oraclelicense=accept-securebackup-cookie" \
  http://download.oracle.com/otn-pub/java/jdk/8u131-b11/d54c1d3a095b4ff2b6607d096fa80163/jre-8u131-windows-x64.exe

#
# Selenium IE Driver and Server
#
# Version 3.4.0
#
wget --directory-prefix=tmp http://selenium-release.storage.googleapis.com/3.4/IEDriverServer_x64_3.4.0.zip
wget --directory-prefix=tmp http://selenium-release.storage.googleapis.com/3.4/selenium-server-standalone-3.4.0.jar

# Prepare shared folder
rm -rf shared && mkdir shared
cp tmp/MicrosoftWebDriver.exe shared
unzip tmp/IEDriverServer_x64_3.4.0.zip -d shared
cp tmp/jre-8u131-windows-x64.exe shared
cp tmp/selenium-server-standalone-3.4.0.jar shared
cp selenium.bat shared

# Start Vagrant
ssh-keygen -t rsa -N '' -f shared/vagrant_key
vagrant up && vagrant reload