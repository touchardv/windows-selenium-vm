
require_relative 'selenium_plugin'

Vagrant.configure('2') do |config|
  config.vm.box = 'Win10_Edge'
  config.vm.guest = :windows

  # Windows is slow to boot...
  config.vm.boot_timeout = 500

  config.vm.communicator = 'ssh'
  config.ssh.username = 'IEUser'
  config.ssh.insert_key = false

  if File.exist?(".vagrant/machines/default/virtualbox/action_provision")
    config.ssh.private_key_path = 'shared/vagrant_key'
  else
    config.ssh.password = 'Passw0rd!'
  end

  config.vm.network 'forwarded_port', guest: 4444, host: 4444

  config.vm.synced_folder '.', '/vagrant', disabled: true
  config.vm.synced_folder 'shared', 'C:/Users/IEUser/shared', create: false

  config.vm.provider 'virtualbox' do |vb|
    vb.gui = true
    vb.customize ['modifyvm', :id, '--memory', '1024']
    vb.customize ['modifyvm', :id, '--vram', '128']
    vb.customize ['modifyvm', :id,  '--cpus', '2']
    vb.customize ['modifyvm', :id, '--natdnsproxy1', 'on']
    vb.customize ['modifyvm', :id, '--natdnshostresolver1', 'on']
    vb.customize ['guestproperty', 'set', :id, '/VirtualBox/GuestAdd/VBoxService/--timesync-set-threshold', 10000]
  end

  config.vm.provision 'file', source: 'shared/vagrant_key.pub', destination: 'C:/Users/IEUser/.ssh/authorized_keys'
  config.vm.provision 'selenium', type: 'selenium_provisioner'
end
