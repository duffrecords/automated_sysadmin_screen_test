# destructor::test_1
class destructor::test_2 {

  $problem_definition = "
Problem:  Users are reporting that the following page is broken:
  http://superstar.admin.com/connect.php

Identify the source of the problem and ensure the page loads without any errors.
"

  $mysql_root_password = 'changeme999'
  $test2_db_user = 'test2user'
  $test2_db_password = 'test123'


  file { '/challenges/problem_2.txt':
    content => $problem_definition,
  }

  host { 'test2.admin.com':
    ip           => $ipaddress,
    host_aliases => 'test2',
  }


  package { ['mariadb', 'mariadb-server']:
    ensure  => installed,
    require => Package['epel-release'],
  }

  service { 'mariadb':
    ensure  => running,
    require => Package['mariadb-server'],
  }

  file { '/root/db_setup.sql':
    content => template('destructor/mysql_setup.sql.erb'),
    require => Package['mariadb'],
  }
  exec { 'mysql_setup':
    command     => '/bin/mysql -u root < /root/db_setup.sql',
    refreshonly => true,
    require     => [Package['mariadb'], Package['mariadb-server']],
    subscribe   => File['/root/db_setup.sql'],
  }
  file { '/root/.my.cnf':
    content   => template('destructor/my.cnf.erb'),
    subscribe => Exec['mysql_setup'],
  }

  file { '/root/test_db_setup.sql':
    content => template('destructor/test2_db_setup.sql.erb'),
    require => Package['mariadb'],
  }
  exec { 'test_db_setup':
    command   => '/bin/mysql --defaults-file=/root/.my.cnf < /root/test_db_setup.sql',
    require   => File['/root/.my.cnf'],
    subscribe => File['/root/test_db_setup.sql'],
  }


  package { ['php-mysql', 'php-fpm']:
    ensure  => installed,
  }

  file { '/etc/php-fpm.d/www.conf':
    ensure => present,
  }
  -> file_line { 'set_php-fpm_user':
    path   => '/etc/php-fpm.d/www.conf',
    line   => 'user = nginx',
    match  => '^user = apache$',
    notify => Service['nginx'],
  }
  -> file_line { 'set_php-fpm_group':
    path   => '/etc/php-fpm.d/www.conf',
    line   => 'group = nginx',
    match  => '^group = apache$',
    notify => Service['nginx'],
  }

  file { '/var/www/connect.php':
    # content => $db_connection_script,
    content => template('destructor/connect.php.erb'),
    require => [File['/var/www'], Package['php-mysql']],
    notify  => Service['nginx'],
  }
}
