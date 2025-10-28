# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx4::service
class fastx4::service {
  service { $fastx4::services:
    ensure => $fastx4::service_ensure,
    enable => $fastx4::service_enabled,
  }
}
