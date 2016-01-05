require "vagrant"
require "vagrant/conductor/version"
require "vagrant/conductor/util/hash"
require "vagrant/conductor/modules/module"
require "vagrant/conductor/modules/modules"
require "vagrant/conductor/plugin"
require "vagrant/conductor/configure"
require "vagrant/conductor/provisioner"

class VagrantConductor

  attr_accessor :config

  def initialize(config)
    @config = config
  end

  def init(config, default = nil)
    args = merge_args(config, default)
    configure_environment(args)
    provision_modules(args)
  end

  def configure_environment(args)
    config = VagrantPlugins::Conductor::Configure.new(@config)
    config.configure(args)
  end

  def provision_modules(args)
    modules = VagrantPlugins::Conductor::Provisioner.new(@config)
    modules.provision(args)
  end

  # Merge arguments from the default config
  def merge_args(config, default = nil)
    args = load(config)
    if !default.nil? && File.exist?(default)
      args.deep_merge(load(default))
    end
    args
  end

  # Load and read a YAML file
  def load(path)
    YAML::load(File.read(path))
  end

end
