# destructor::test_1
class destructor::test_1 {

  $problem_definition = '
Problem: This server runs a site http://superstar.admin.com.  A secret
intelligence agency just reported that this server is going to be flooded with
requests from few malicious nodes.  Good news is that agency has identified the
IP addresses of those hosts.  Please block any tcp traffic coming from these
addresses.

Note: Please look for file that has list of IPs in same directory as this
problem statement.
'

  file { '/challenges/problem_1.txt':
    content => $problem_definition,
  }

  file{'IP List':
    ensure  => present,
    path    => '/challenges/ip_list.txt',
    require => [File['/challenges/problem_1.txt']],
    source  => 'puppet:///modules/destructor/ip_list.txt',
  }

  host { 'superstar.admin.com':
    ip           => $ipaddress,
    host_aliases => 'superstar',
  }

  package { 'epel-release':
    ensure => installed,
  }
  -> package { 'hping3':
    ensure => installed,
  }

  package { 'nginx':
    ensure => installed,
  }


  file { ['/var/www','/var/www/app']:
    ensure => 'directory',
    owner  => 'nginx',
    mode   => '0750',
  }

  file { '/var/www/index.html':
    content => 'Awesome!',
  }



  file{'superstar.admin.com.conf':
    ensure  => present,
    path    => '/etc/nginx/conf.d/superstar.admin.com.conf',
    require => [Package[nginx]],
    source  => 'puppet:///modules/destructor/nginx.superstar.admin.com.conf',
  }

  service { 'nginx':
    ensure     => running,
    enable     => true,
    hasrestart => true,
    require    => File['/etc/nginx/conf.d/superstar.admin.com.conf'],
    restart    => '/etc/init.d/nginx reload',
  }



}
