class { 'java':
    distribution => 'jre',
}

class { 'neo4j':
    require                     => Class['java'],
    version                     => '2.3.1',
    edition                     => 'community',
    install_prefix              => '/opt/neo4j',
    jvm_init_memory             => '128',
    jvm_max_memory              => '128',
    allow_remote_connections    => true,
    address                	    => '0.0.0.0',
}

# install git, nodejs, npm
class { 'packages': 
    require     => Class['neo4j'],
}

# install python dependencies
class {'python': 
    require     => Class['packages'],
}

# create node-user
class { 'users':
    require     => Class['packages'],
}

# clone churchill into vagrant shared folder
vcsrepo { '/vagrant/churchill':
    require     => Class['users'],
    ensure      => present,
    provider    => git,
    source      => 'https://github.com/psu-capstone/churchill.git',
    revision    => 'develop',
}

# create symlink so node-user service can access churchill
file { '/home/node-user/churchill': 
    require     => Vcsrepo['/vagrant/churchill'],
    ensure      => link,
    target      => '/vagrant/churchill',
    owner       => node-user,
    group       => node-user,
}

# deploy upstart script to start churchill as service
class { 'churchill-node':
    require     => File['/home/node-user/churchill'],
}

