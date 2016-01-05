module VagrantPlugins
  module Conductor
    class Modules

      attr_accessor :modules
      attr_accessor :args
      attr_accessor :config
      attr_accessor :sync_path

      def initialize(modules, args, config, sync_path)
        @modules = modules
        @args = args
        @config = config
        @sync_path = sync_path
      end

      def get_defaults(path)
        YAML::load(File.read(path + '/config.yml'))
      end

      def get_classname(hash)
        classname = hash.find?('classname', nil)
        hash.delete('classname')
        classname
      end

      def merge_defaults(name, args, defaults)
        if args.kind_of?(Array)
          defaults.deep_merge({name => args})
        elsif args.kind_of?(Hash)
          defaults.deep_merge(args)
        elsif args.kind_of?(String)
          args;
        end
      end

      def init()
        initialized = Hash.new
        @modules.each do |path|
          name = File.basename(path)
          params = args.find?(name, nil)

          # Skip if module not requested
          next if params.nil?

          require path + "/#{name}"
          defaults = get_defaults(path)
          classname = get_classname(defaults)
          params = merge_defaults(name, params, defaults)

          initialized[name] = Kernel.const_get(classname).new(@config, params, path, @sync_path + "/#{name}")
        end
        initialized
      end

    end
  end
end