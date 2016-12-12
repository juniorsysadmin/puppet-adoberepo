require 'spec_helper'

describe 'adoberepo', type: :class do
  context 'RedHat osfamily with no parameters, 64 bit' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    it { is_expected.to compile.with_all_deps }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_baseurl('http://linuxdownload.adobe.com/linux/x86_64/') }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_descr('Adobe YUM repository') }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_enabled('1') }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_gpgcheck('1') }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_gpgkey('file:///etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux') }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_proxy('absent') }
    it { is_expected.to contain_gpg_key('adobe-linux-x86_64').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux') }
  end

  context 'RedHat osfamily with no parameters, 32 bit' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'i386' } }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_baseurl('http://linuxdownload.adobe.com/linux/i386/') }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_descr('Adobe YUM repository') }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_enabled('1') }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_gpgcheck('1') }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_gpgkey('file:///etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux') }
    it { is_expected.to contain_yumrepo('adobe-linux-i386').with_proxy('absent') }
    it { is_expected.to contain_gpg_key('adobe-linux-i386').with_path('/etc/pki/rpm-gpg/RPM-GPG-KEY-adobe-linux') }
  end

  context 'Fedora with repo baseurl set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { 'adoberepo_baseurl' => 'http://mirror.domain.com' } }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_baseurl('http://mirror.domain.com') }
  end

  context 'Fedora with repo description set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { 'adoberepo_descr' => 'This is a description' } }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_descr('This is a description') }
  end

  context 'Fedora with repo enabled set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { adoberepo_enabled: '1' } }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_enabled('1') }
  end

  context 'Fedora with repo gpgcheck set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { adoberepo_gpgcheck: '1' } }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_gpgcheck('1') }
  end

  context 'Fedora with repo name set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { adoberepo_name: 'Adobe flash repository' } }
    it { is_expected.to contain_yumrepo('Adobe flash repository') }
  end

  context 'Fedora with repo proxy set' do
    let(:facts) { { osfamily: 'RedHat', operatingsystem: 'Fedora', architecture: 'x86_64' } }
    let(:params) { { adoberepo_proxy: 'http://proxy.domain.com' } }
    it { is_expected.to contain_yumrepo('adobe-linux-x86_64').with_proxy('http://proxy.domain.com') }
  end

  context 'Non-RedHat osfamily' do
    let(:facts) { { osfamily: 'Debian', operatingsystem: 'Ubuntu', architecture: 'x86_64' } }
    it { is_expected.to compile.with_all_deps }
  end
end
