class adoberepo::params {
  $adoberepo_baseurl       = "http://linuxdownload.adobe.com/linux/${::architecture}/"
  $adoberepo_descr         = 'Adobe YUM repository'
  $adoberepo_ensure        = 'present'
  $adoberepo_enabled       = 1
  $adoberepo_gpgcheck      = 1
  $adoberepo_name          = "adobe-linux-${::architecture}"
  $adoberepo_proxy         = 'absent'
  $adoberepo_repo_gpgcheck = 1
}
