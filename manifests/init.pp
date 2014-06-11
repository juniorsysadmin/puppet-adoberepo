# == Class: adoberepo
#
# This module installs and enables the Adobe YUM repository. When run on a
# non-RedHat osfamily it exits.
#
# === Parameters
#
# [*adoberepo_baseurl*]
# Defaults to http://linuxdownload.adobe.com/linux/${::architecture}/
#
# [*adoberepo_enabled*]
# Defaults to 1
#
# [*adoberepo_gpgcheck*]
# Defaults to 1
#
# [*adoberepo_proxy*]
# Defaults to absent. (Uses the yum.conf value if it exists)
#
# === Usage
#
# include '::adoberepo'
#
# or alternatively:
#
#  class { 'adoberepo':
#    adoberepo_baseurl => 'http://localmirror.server.domain'
#  }
#
class adoberepo (
  $adoberepo_baseurl                           = $adoberepo::params::adoberepo_baseurl,
  $adoberepo_enabled                           = $adoberepo::params::adoberepo_enabled,
  $adoberepo_gpgcheck                          = $adoberepo::params::adoberepo_gpgcheck,
  $adoberepo_proxy                             = $adoberepo::params::adoberepo_proxy,
) inherits adoberepo::params {

  if ($::osfamily == 'RedHat') {

    yumrepo { "adobe-linux-${::architecture}":
      baseurl        => $adoberepo_baseurl,
      proxy          => $adoberepo_proxy,
      enabled        => $adoberepo_enabled,
      gpgcheck       => $adoberepo_gpgcheck,
      gpgkey         => 'file:///etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux',
      descr          => 'Adobe YUM repository',
    }

    file { '/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux':
      ensure => present,
      owner  => 'root',
      group  => 'root',
      mode   => '0644',
      source => 'puppet:///modules/adoberepo/RPM-GPG-KEY-adobe-linux',
    }

    adoberepo::rpm_gpg_key{ "adobe-linux-${::architecture}":
      path    => '/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux',
      before  => Yumrepo["adobe-linux-${::architecture}"]
    }

  }

  else {
    notice ("Your operating system ${::operatingsystem} will not have the Adobe YUM repository applied")
  }

}