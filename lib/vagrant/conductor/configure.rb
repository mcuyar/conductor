module VagrantPlugins
  module Conductor

    # This class will configure a vagrant environment.
    class Configure

      attr_accessor :config

      def initialize(config)
        @config = config
      end

      def configure(args)

        # Configure The Box
        set_box(
            args.find?('box', 'bento/ubuntu-14.04'),
            args.find?('box_version', nil)
        )

        # Set the environments hostname
        set_hostname(args.find?('hostname', 'conductor'))

        # Configure A Private Network IP
        set_private_ip(args.find?('ip', '192.168.10.10'))

        # Configure A Few VirtualBox Settings
        set_provider_config(
          args.find?('memory', '2048'),
          args.find?('cpus', '1')
        )

        # Configure Port Forwarding
        set_forwarded_ports(args.find?('forward_ports', []))

      end

      # Set the vagrant box and version
      def set_box(box, version = nil)
        @config.vm.box = box
        unless version.nil?
          @config.vm.box_version = version
        end
      end

      # Set the vagrant hostname
      def set_hostname(hostname)
        @config.vm.hostname = hostname;
      end

      # Configure A Private Network IP
      def set_private_ip(ip)
        @config.vm.network :private_network, ip: ip
      end

      def set_provider_config(memory, cpus)
        @config.vm.provider "virtualbox" do |vb|
          vb.customize ["modifyvm", :id, "--memory", memory]
          vb.customize ["modifyvm", :id, "--cpus", cpus]
          vb.customize ["modifyvm", :id, "--natdnsproxy1", "on"]
          vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
        end
      end

      # Forward an array or hash of ports
      def set_forwarded_ports(ports)
        if ports.is_a?(Array)
          set_forwarded_ports_from_array(ports)
        elsif ports.is_a?(Hash)
          set_forwarded_ports_from_hash(ports)
        end
      end

      # set forwarded ports from an array
      def set_forwarded_ports_from_array(ports)
        ports.each { |val|
          guest, host = val.split(':', 2)
          forward_port(guest, host)
        }
      end

      # Set forwarded ports from a hash
      def set_forwarded_ports_from_hash(ports)
        ports.each do |key, val|
          guest, host = val.split(':', 2)
          forward_port(guest, host)
        end
      end

      # Forwad port from guest/host
      def forward_port(guest, host)
        @config.vm.network "forwarded_port", guest: guest, host: host
      end

    end
  end
end