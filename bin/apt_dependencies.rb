module AptDependencies
  extend self

  def self.ensure!
    return "true" if deps_to_install.none?
    if sudo_password_required? && ENV["RAILS_ENV"] != "development"
      $stderr.puts "sudo requires password! cannot install #{deps_to_install.join(' ')}"
      exit 1
    else
      system "sudo DEBIAN_FRONTEND=noninteractive apt-get update -y && sudo DEBIAN_FRONTEND=noninteractive apt-get install -y #{deps_to_install.join(' ')}"
    end
  end

  private

  def deps_to_install
    deps.reject do |dep|
      system("dpkg-query -W -f='${Status}' #{dep} 2>/dev/null > /dev/null")
    end
  end

  def deps
    @deps ||= File.readlines("Aptfile", chomp: true).select { |line| line.length > 0 }
  rescue Errno::ENOENT
    @deps = []
  end

  def sudo_password_required?
    !system("sudo -n true 2>/dev/null")
  end
end

