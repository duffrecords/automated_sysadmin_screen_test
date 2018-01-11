#!/bin/bash

rpm -qa | grep -q puppet-agent
if [ $? -ne 0 ]; then
  rpm -Uvh https://yum.puppetlabs.com/puppet5/puppet5-release-el-7.noarch.rpm
  yum -y install puppet-agent
fi
