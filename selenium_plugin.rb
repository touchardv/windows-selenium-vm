require 'vagrant'

require 'log4r'
require 'net/ssh'

module VagrantPlugins
  module Selenium
    class Plugin < Vagrant.plugin('2')
      name 'Selenium for Windows'

      provisioner(:selenium_provisioner) do
        SeleniumProvisioner
      end
    end
  end

  class SeleniumProvisioner < Vagrant.plugin('2', :provisioner)
    def provision
      begin
        Net::SSH.start('localhost', 'IEUser', password: 'Passw0rd!', port: 2222)  do |ssh|
          puts 'Turning off firewall...'
          output = ssh.exec!('cmd /c "C:\Windows\system32\netsh.exe advfirewall set allprofiles state off"')
          puts output

          puts 'Installing Java Runtime Environment...'
          output = ssh.exec!('cmd /c "C:\Users\IEUser\shared\jre-8u131-windows-x64.exe /s INSTALLDIR=C:\Java"')
          puts output

          puts 'Copying Selenium Server...'
          output = ssh.exec!('cmd /c "copy shared\selenium-server-standalone-3.4.0.jar C:\Users\IEUser"')
          puts output

          puts 'Copying Microsoft Edge Web Driver...'
          output = ssh.exec!('cmd /c "copy shared\MicrosoftWebDriver.exe C:\Java\bin"')
          puts output

          puts 'Copying Microsoft IE Web Driver...'
          output = ssh.exec!('cmd /c "copy shared\IEDriverServer.exe C:\Java\bin"')
          puts output

          puts 'Copying Selenium startup batch...'
          output = ssh.exec!('cmd /c "copy shared\selenium.bat C:\Users\IEUser"')
          puts output

          puts 'Creating Selenium startup link...'
          output = ssh.exec!('cmd /c "mklink "C:\\\\Users\\\\IEUser\\\\AppData\\\\Roaming\\\\Microsoft\\\\Windows\\\\Start Menu\\\\Programs\\\\Startup\\\\selenium.lnk" C:\Users\IEUser\selenium.bat"')
          puts output
        end
      rescue => ex
        puts "Error: #{ex.message}"
        raise ex
      end
    end
  end
end
