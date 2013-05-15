require "puppet/util/execution"

Puppet::Type.type(:nodejs).provide :nodenv do
  include Puppet::Util::Execution

  def create
    command = [
      "#{root}/bin/nodenv",
      "install",
      @resource[:version]
    ]

    command << "--source" if @resource[:compile]

    execute command, command_opts
  end

  def destroy
    command = [
      "#{root}/bin/nodenv",
      "uninstall",
      @resource[:version]
    ]

    execute command, command_opts
  end

  def exists?
    File.directory? "#{root}/versions/#{@resource[:version]}"
  end

  def command_opts
    {
      :combine            => true,
      :custom_environment => {
        "NODENV_ROOT" => root
      },
      :failonfail         => true,
      :uid                => Facter[:boxen_user].value
    }
  end

  def root
    @root ||= "#{Facter[:boxen_home].value}/nodenv"
  end
end
