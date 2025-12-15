# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx4::configure
class fastx4::configure {
  file { "${fastx4::configdir}/fastx.env":
    replace => false,
    owner   => $fastx4::service_user,
    group   => $fastx4::service_group,
    mode    => '0600',
    content => "# managed by puppet\n",
  }
  $fastx4::fastx_env.each |$k, $v| {
    file_line { "fast.env: ${k}=${v}":
      path    => "${fastx4::configdir}/fastx.env",
      line    => "${k}=${v}",
      match   => "^${k}=",
      require => File["${fastx4::configdir}/fastx.env"],
    }
  }
  $fastx4::config.each |$f, $config| {
    $file_name = "${fastx4::configdir}/${f}.ini"
    file { $file_name:
      replace => false,
      owner   => $fastx4::service_user,
      group   => $fastx4::service_group,
      mode    => '0644',
    }
    $config.each |$i| {
      ini_setting { "set ${i['setting']} in ${file_name}":
        path => $file_name,
        *    => $i,
      }
    }
  }
  if $fastx4::license_server =~ Stdlib::Fqdn {
    file { $fastx4::license_file:
      owner   => $fastx4::service_user,
      group   => $fastx4::service_group,
      mode    => '0644',
      content => "HOST ${fastx4::license_server} 00000000 5053\n",
    }
  }
}
