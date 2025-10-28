# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx4::install
class fastx4::install {
  package { $fastx4::packages:
    ensure => installed,
  }
}
