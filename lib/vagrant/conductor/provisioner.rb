module VagrantPlugins
  module Conductor

    # This class implements provisioning via conductor modules.
    class Provisioner

      attr_reader :config
      attr_reader :path
      attr_reader :sync_path
      attr_reader :initialized

      # Initialize the provisioner
      def initialize(config)
        @config = config
        @path = File.expand_path('modules', __dir__)
        @sync_path = sync_folder
        @initialized = Hash.new
      end

      def provision(args)
        modules = VagrantPlugins::Conductor::Modules.new(available_modules(@path), args, @config, @sync_path)
        @initialized = modules.init

        if ENV.has_key?('MODULE') && @initialized.has_key?(ENV['MODULE'])
          @initialized[ENV['MODULE']].provision
        else
          @initialized.each do |name, object|
            object.provision
          end
        end

      end

      # set the sync folder
      def sync_folder
        sync_path = '/tmp/conductor/modules'
        @config.vm.synced_folder @path, sync_path
        sync_path
      end

      # Get a list of the available modules
      def available_modules(path)
        Dir.glob(path + '/*').select { |f| File.directory? f }
      end

    end # Provisioner
  end # Conductor
end # VagrantPlugins