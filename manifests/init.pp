# @summary install and configure fastx4
#
# install and configure fastx4
#
# @param vardir
#   directory for some configuration
# @example
#   include fastx4
class fastx4 (
  Stdlib::Absolutepath $vardir = '/var/fastx',
  Stdlib::Absolutepath $configdir = '/etc/fastx',
  Variant[String,Array[String]] $packages = 'fastx4-server',
  String $service_user = 'fastx',
  String $service_group = 'fastx',
  Optional[Stdlib::Fqdn] $license_server = undef,
  Stdlib::Absolutepath $licensedir = "${fastx4::vardir}/license",
  Stdlib::Absolutepath $license_file = "${fastx4::licensedir}/license_server.lic",
  Variant[Array[String],String] $services = 'fastx4',
  Variant[Enum['running','stopped'],Undef] $service_ensure = 'running',
  Boolean $service_enabled = true,
  Hash[String,String] $loglevel_config = {'**' => 'info'},
) {
  include stdlib
  contain fastx4::install
  contain fastx4::configure
  contain fastx4::service
  Class['fastx4::install']
  -> Class['fastx4::configure']
  ~> Class['fastx4::service']
}
