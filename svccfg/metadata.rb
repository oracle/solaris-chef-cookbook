name              'svccfg'
maintainer        'Pradhap Devarajan'
maintainer_email  'pradhap.devarajan@oracle.com'
license           'Apache 2.0'
description       'Installs/Configures svccfg'
long_description IO.read(File.join(File.dirname(__FILE__),'README.md'))
version           '0.1.0'
supports          'solaris2'
source_url        'https://github.com/oracle/solaris-chef-cookbook'
issues_url        'https://github.com/oracle/solaris-chef-cookbook/issues'
chef_version      '>= 12.5' if respond_to?(:chef_version)

