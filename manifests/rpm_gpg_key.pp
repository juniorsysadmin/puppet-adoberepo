# == Define: rpm_gpg_key
# Imports a RPM gpg key. This defined type has been taken straight from the
# epel module. See the epel module for authors/contributors of this code.
#
# === Parameters
#
# [*path*]
# Path of the RPM GPG key to import
#
# === Usage
# adoberepo::rpm_gpg_key{ "adoberepo-${::architecture}":
#   path => '/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux'
# }
#
define adoberepo::rpm_gpg_key($path) {
  # Given the path to a key, see if it is imported, if not, import it
  exec {  "import-${name}":
    path      => '/bin:/usr/bin:/sbin:/usr/sbin',
    command   => "rpm --import ${path}",
    unless    => "rpm -q gpg-pubkey-$(echo $(gpg --throw-keyids < ${path}) | cut --characters=11-18 | tr '[A-Z]' '[a-z]')",
    require   => File[$path],
    logoutput => 'on_failure',
  }
}