# @summary manage fastx4 service user and group
#
# Internal, not used directly.
class fastx4::users {
  if ($fastx4::manage_service_user) {
    group { $fastx4::service_group:
      gid    => $fast4::service_gid,
      ensure => present,
    }
    -> user { $fastx4::service_user:
      system  => true,
      shell   => '/sbin/nologin',
      gid     => $fastx4::service_group,
      uid     => $fastx4::service_uid,
      home    => $fastx4::service_user_home_directory,
    }
  }
}
