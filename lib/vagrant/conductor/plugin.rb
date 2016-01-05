module VagrantPlugins
  module Conductor
    class Plugin < Vagrant.plugin('2')

      name "Conductor"

      description <<-DESC
      Provides support for provisioning your virtual machines with
      module scripts.
      DESC

    end
  end
end