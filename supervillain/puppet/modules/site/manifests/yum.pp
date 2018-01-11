# update local metadata cache
class site::yum {
    exec{'yum makecache':
            command => '/usr/bin/yum makecache',
    }
}
