require 'formula'

class Neo4j < Formula
  url 'http://dist.neo4j.org/neo4j-community-1.6-unix.tar.gz'
  version 'community-1.6'
  homepage 'http://neo4j.org'
  md5 'd9b12bbd269853c2a85ed12595e50409'

  def install
    # Remove windows files
    rm_f Dir["bin/*.bat"]

    # Fix the permissions on the global settings file.
    chmod 0644, Dir["config"]

    # Install jars in libexec to avoid conflicts
    libexec.install Dir['*']

    # Symlink binaries
    bin.mkpath
    ln_s "#{libexec}/bin/neo4j", bin+"neo4j"
    ln_s "#{libexec}/bin/neo4j-shell", bin+"neo4j-shell"
  end

  def caveats; <<-EOS.undent
    Quick-start guide:

        1. Start the server manually:
            neo4j start

        2. Open webadmin:
            open http://localhost:7474/webadmin/

        3. Start exploring the REST API:
            curl -v http://localhost:7474/db/data/

        4. Stop:
            neo4j stop

    To launch on startup, install launchd-agent to ~/Library/LaunchAgents/ with:
        neo4j install

    If this is an upgrade, see:
        #{libexec}/UPGRADE.txt

    The manual can be found in:
        #{libexec}/doc/

    EOS
  end
end
