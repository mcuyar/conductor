module VagrantPlugins
  module Conductor
    module Module

        attr_accessor :config, :args, :scripts, :templates

        def initialize(config, args, path, sync_path)
          @config = config
          @args = args
          @scripts = sync_path + "/scripts"
          @templates = path + "/templates"
        end

        # Create the template
        def generate_template(vars, template_file)
          require 'erb'
          template = File.read(@templates + "/#{template_file}.erb")
          ERB.new(template).result(binding)
        end

        def shell_provision(inline, args = nil, privileged = true)
          @config.vm.provision "shell" do |s|
            s.inline = inline
            s.args = args
            s.privileged = privileged
          end
        end

    end
  end
end