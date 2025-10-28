# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx4::configure
class fastx4::configure {
  $fastx4::loglevel_config.each |$k, $v| {
    ini_setting { "loglevel.ini: ${k}: ${v}":
      path    => "${fastx4::configdir}/loglevel.ini",
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
