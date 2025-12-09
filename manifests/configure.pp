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
  }
  $fastx4::fastx_env.each |$k, $v| {
    file_line { "fast.env: ${k}=${v}":
      path  => "${fastx4::configdir}/fastx.env",
      line  => "${k}=${v}",
      match => "^${k}=",
    }
  }
  ['auth-oidc', 'loglevel', 'https', 'permissions'].each |$f| {
    file { "${fastx4::configdir}/${f}.ini":
      replace => false,
      owner   => $fastx4::service_user,
      group   => $fastx4::service_group,
      mode    => '0644',
    }
  }
  $fastx4::auth_oidc_config.each |$k, $v| {
    ini_setting { "auth-oidc.ini: ${k}: ${v}":
      path    => "${fastx4::configdir}/auth-oidc.ini",
      setting => $k,
      value   => $v,
    }
  }
  $fastx4::loglevel_config.each |$k, $v| {
    ini_setting { "loglevel.ini: ${k}: ${v}":
      path    => "${fastx4::configdir}/loglevel.ini",
      setting => $k,
      value   => $v,
    }
  }
  $fastx4::https_config.each |$k, $v| {
    ini_setting { "https.ini: ${k}: ${v}":
      path    => "${fastx4::configdir}/https.ini",
      #section => $section,
      setting => $k,
      value   => $v,
    }
  }
  $fastx4::permissions_config.each |$k, $v| {
    ini_setting { "permissions.ini: ${k}: ${v}":
      path    => "${fastx4::configdir}/permissions.ini",
      #section => $section,
      setting => $k,
      value   => $v,
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
