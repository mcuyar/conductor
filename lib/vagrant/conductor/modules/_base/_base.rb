class BaseProvisioner

  include VagrantPlugins::Conductor::Module

  def provision

    unless args.find?('install', false)
      return
    end

    shell_provision(%{
      bash #{@scripts}/system.sh
      bash #{@scripts}/grub.sh
      bash #{@scripts}/mysql.sh
      bash #{@scripts}/postgresql.sh
      bash #{@scripts}/php.sh
      bash #{@scripts}/nginx.sh
      bash #{@scripts}/composer.sh
      bash #{@scripts}/redis.sh
      bash #{@scripts}/memcache.sh
      bash #{@scripts}/sqlite.sh
      bash #{@scripts}/nodejs.sh
      bash #{@scripts}/beanstalkd.sh
      bash #{@scripts}/xdebug.sh
      bash #{@scripts}/python-pip.sh
    }, nil, true)

    # Minimize The Disk Image
    shell_provision(%{
      echo 'Minimizing disk image...'
      dd if=/dev/zero of=/EMPTY bs=1M
      rm -f /EMPTY
      sync
    }, nil, true)

  end

end