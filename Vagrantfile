
Vagrant.configure('2') do |config|

  default = File.expand_path('config-default.yml', __dir__)
  custom = File.expand_path('config.yml', __dir__)

  conductor = VagrantConductor.new(config)
  conductor.init(custom, default)

end