# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include fastx4::install
class fastx4::install {
  if $fastx4::manage_repos {
    create_resources(
      'yumrepo',
      $fastx4::yumrepos,
      { before => Package[$fastx4::packages] },
    )
  }
  package { $fastx4::packages:
    ensure => installed,
  }
}
