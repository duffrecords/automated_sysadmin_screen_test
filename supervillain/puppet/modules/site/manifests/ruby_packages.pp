# ruby_packages
class site::ruby_packages{
  package { 'bundler':
    ensure   => installed,
    provider => 'gem',
    require  => Package['rubygems'],
  }
  package { 'rack':
    ensure   => '1.6.0',
    provider => 'gem',
    require  => Package['rubygems'],
  }
  package { 'thin':
    ensure   => '1.7.2',
    provider => 'gem',
    require  => [Package['rubygems'],Package['ruby-devel']],
  }
  package { 'foreman':
    ensure   => installed,
    provider => 'gem',
    require  => Package['rubygems'],
  }
  package { 'rspec':
    ensure   => installed,
    provider => 'gem',
    require  => Package['rubygems'],
  }
}
