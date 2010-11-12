#
# resolvconf module
#
# Copyright 2008, admin(at)immerda.ch
# Copyright 2008, Puzzle ITC GmbH
# Copyright 2010, Atizo AG
# Marcel Härry haerry+puppet(at)puzzle.ch
# Simon Josi simon.josi+puppet(at)atizo.com
#
# This program is free software; you can redistribute 
# it and/or modify it under the terms of the GNU 
# General Public License version 3 as published by 
# the Free Software Foundation.
#

class resolvconf(
  $resolv_domain = false,
  $resolv_search = false,
  $resolv_nameservers = false
){
  if $operatingsystem == 'openbsd' {
    info('$resolv_domain and $resolv_search not needed on openbsd')
  } else {
    if ! $resolv_domain {
      fail("you need to define \$resolv_domain for $fqdn")
    }
    if ! $resolv_search {
      fail("you need to define \$resolv_search for $fqdn")
    }
  }
  if ! $resolv_nameservers {
    fail("you need to define \$resolv_nameservers for $fqdn")
  }
  file{'/etc/resolv.conf':
    path => '/etc/resolv.conf',
    owner => root, group => 0, mode => 0444,
    content => $operatingsystem ? {
      openbsd => template("resolvconf/resolvconf.$operatingsystem.erb"),
      default => template('resolvconf/resolvconf.erb'),
    }
  }
}
