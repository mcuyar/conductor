class AmazonWebServices

  include VagrantPlugins::Conductor::Module

  def create_profiles
    profiles = args.find?('profiles', [])
    create(profiles, "credentials")
    create(profiles, "config")
  end

  def create(profiles, template_file)
    result = generate_template(profiles, template_file)
    # Add template to vagrant home directory
    shell_provision(
        "bash #{@scripts}/awsconfig.sh \"$1\" $2",
        [result, template_file]
    )
  end

  def install_aws_cli

  end

  def install_eb_cli
    shell_provision(
        "bash #{@scripts}/elasticbeanstalk.sh"
    )
  end

  def provision

    if args.find?('install', false)
      shell_provision("bash #{@scripts}/awscli.sh", nil, true)
    end

  end

end