node default {
    Exec { path => '/usr/bin:/usr/sbin:/bin:/sbin:/usr/local/bin:/usr/local/sbin'}

    # ensures proper ordering of provisioning
    stage { first: before => Stage[main] }
    stage { last: require => Stage[main] }

    # add includes here
    include site::init
    include stdlib
    # include core::yeoman
    include core::curl
    # include core::yeoman
    # include core::apache2
    include core::git
    # include core::mysql5
    # include core::php5
    # include core::python
    include core::ruby
    include core::vim
    # include site::php-packages
    # include site::python-packages
    include site::ruby_packages
    # include site::apache-vhosts
    # include site::apache-modules
    include destructor::base
    include destructor::test_1
    include destructor::test_2
}
