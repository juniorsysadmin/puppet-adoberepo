# Optional parameters in setting up the Adobe YUM repository
class adoberepo::params {
  $adoberepo_baseurl                           = "http://linuxdownload.adobe.com/linux/${::architecture}/"
  $adoberepo_enabled                           = '1'
  $adoberepo_gpgcheck                          = '1'
  $adoberepo_proxy                             = $proxy
  $proxy                                       = 'absent'
}