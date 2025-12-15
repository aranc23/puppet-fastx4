# @summary install and configure fastx4
#
# install and configure fastx4
#
# @param vardir
#   directory for some configuration
# @param localdir
#   local version of vardir, presumably not automounted
# @param configdir
#   config file location, possibly a file share in a network cluster
# @param packages
#   packages to be installed
# @param service_user
#   config files owned by this user
# @param service_group
#   config file group
# @param service_ensure
#   passed to service def.
# @param service_enabled
#   passed to service definition
# @param config
#   hash of filenames and parameters
# @param fastx_env
#   used to create fastx.env, environment variables that configure
#   fastx4
# @example
#   include fastx4
class fastx4 (
  Stdlib::Absolutepath $vardir = '/var/fastx',
  Stdlib::Absolutepath $localdir = '/var/fastx-local',
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
  Hash[String,Array[Struct[
    {
      ensure  => Optional[Enum['present','absent']],
      section => Optional[String],
      setting => String,
      value => Variant[String,Integer,Float],
    }
  ]]] $config = {
    'loglevel' => [
      {
        'setting' => '**',
        'value'   => 'info',
      }
    ],
  },
  Hash[String,Variant[String,Integer]] $fastx_env = {},
  Boolean $manage_repos = true,
  Hash $yumrepos = {},
) {
  include stdlib
  contain fastx4::install
  contain fastx4::configure
  contain fastx4::service
  Class['fastx4::install']
  -> Class['fastx4::configure']
  ~> Class['fastx4::service']
}
