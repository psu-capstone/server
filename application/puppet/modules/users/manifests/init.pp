class users {
    
    group { 'www-data':
        ensure => present,
    }

    user { 'node-user':
        require     => Group['www-data'],
        ensure      => present,
        groups      => ['www-data'],
        managehome  => true,
        shell       => "/bin/bash",
    }
    
    user { 'api-user':
        require     => Group['www-data'],
        ensure      => present,
        groups      => ['www-data'],
        managehome  => true,
        shell       => "/bin/bash",
    }
}

