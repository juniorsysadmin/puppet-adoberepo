class adoberepo (
  $adoberepo_baseurl       = $adoberepo::params::adoberepo_baseurl,
  $adoberepo_descr         = $adoberepo::params::adoberepo_descr,
  $adoberepo_enabled       = $adoberepo::params::adoberepo_enabled,
  $adoberepo_ensure        = $adoberepo::params::adoberepo_ensure,
  $adoberepo_gpgcheck      = $adoberepo::params::adoberepo_gpgcheck,
  $adoberepo_name          = $adoberepo::params::adoberepo_name,
  $adoberepo_proxy         = $adoberepo::params::adoberepo_proxy,
  $adoberepo_repo_gpgcheck = $adoberepo::params::adoberepo_repo_gpgcheck,
) inherits adoberepo::params {

  if ($::osfamily == 'RedHat') {

    yumrepo { $adoberepo_name:
      ensure        => $adoberepo_ensure,
      baseurl       => $adoberepo_baseurl,
      descr         => $adoberepo_descr,
      enabled       => $adoberepo_enabled,
      gpgcheck      => $adoberepo_gpgcheck,
      gpgkey        => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux',
      proxy         => $adoberepo_proxy,
      repo_gpgcheck => $adoberepo_repo_gpgcheck,
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux':
      ensure => file,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/adoberepo/RPM-GPG-KEY-adobe-linux',
      before => Yumrepo[$adoberepo_name],
    }

  }

  else {
    notice ("Your operating system ${::operatingsystem} will not have the Adobe YUM repository applied")
  }

}
