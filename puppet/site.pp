node default {
    include apt
    include stdlib
    include python
    include coffeescript
    include nodejs
    include rvm
    
    rvm_system_ruby { 'ruby-2.1.2':
        ensure      => 'present',
        default_use => true;
    }

    git::config { 'user.name':
        value => 'Songsterr',
    }
    
    git::config { 'user.email':
        value => 'hq@demax.ru',
    }


    package { 'npm': 
        name    => 'npm',
        ensure  => present,
        require => Anchor['nodejs::repo']
    }
    
    file { '/usr/bin/node':
       ensure => 'link',
       target => '/usr/bin/nodejs',
    }

    package { 'bower':
        ensure   => present,
        provider => 'npm',
        require => Package['npm'],
    }
    
    package { ['git', 'screen', 'php5', 'php5-cli', 'php5-json']:
        ensure => present,
    }
    
    package { 'libpq-dev': 
        ensure => present,
    }
    
    package { ['sass', 'compass', 'bundler', 'rake']:
        ensure => 'installed',
        provider => 'gem',
    }
    
    class { 'postgresql::server': 
        manage_pg_hba_conf => false,
    }
    
    file { '/etc/postgresql/9.3/main/pg_hba.conf':
        ensure => file,
        owner  => 'postgres',
        group  => 'postgres',
        mode   => '0640',
        source => '/vagrant/puppet/resources/postgresql/pg_hba.conf',
        require => Package['postgresql-server'],
    }

   # postgresql::server::pg_hba_rule { '"local" is for Unix domain socket connections only':
   #     description => "local is for Unix domain socket connections only",
   #     type => 'local',
   #     database => 'all',
   #     user => 'all',
   #     address => '',
   #     auth_method => 'trust',
   # }
    
   # postgresql::server::pg_hba_rule { 'IPv4 local connections:':
   #     description => "IPv4 local connections:",
   #     type => 'host',
   #     database => 'all',
   #     user => 'all',
   #     address => '127.0.0.1/32',
   #     auth_method => 'trust',
   # }
    
   # postgresql::server::pg_hba_rule { 'IPv6 local connections:':
   #     description => "IPv6 local connections:",
   #     type => 'host',
   #     database => 'all',
   #     user => 'all',
   #     address => '::1/128',
   #     auth_method => 'trust',
   # }
    
    postgresql::server::role { 'eploko':
        password_hash => postgresql_password('eploko', ''),
        superuser     => true,
    }
    
    # postgresql::server::db { 'markerr_production':
    #     user     => 'eploko',
    #     owner    => 'eploko',
    #     grant    => 'ALL',
    #     password => postgresql_password('eploko', ''),
    # }
    
    # postgresql::server::db { 'markerr_development':
    #     user     => 'eploko',
    #     owner    => 'eploko',
    #     grant    => 'ALL',
    #     password => postgresql_password('eploko', ''),
    # }

    # postgresql::server::db { 'markerr_test':
    #     user     => 'eploko',
    #     owner    => 'eploko',
    #     grant    => 'ALL',
    #     password => postgresql_password('eploko', ''),
    # }
    
   # postgresql::server::database_grant { 'markerr_production':
   #     privilege => 'ALL',
   #     db        => 'markerr_production',
   #     role      => 'eploko',
   # }
    
   # postgresql::server::database_grant { 'markerr_development':
   #     privilege => 'ALL',
   #     db        => 'markerr_development',
   #     role      => 'eploko',
   # }
    
   # postgresql::server::database_grant { 'markerr_test':
   #     privilege => 'ALL',
   #     db        => 'markerr_test',
   #     role      => 'eploko',
   # }
    
}