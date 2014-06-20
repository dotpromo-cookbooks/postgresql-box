name 'dotpromo-postgresql-box'
maintainer '.PROMO Inc.'
maintainer_email 'Alexander Simonov <alex@simonov.me>'
license 'MIT'
description 'Installs/Configures PostgreSQL box'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '0.1.0'

supports 'ubuntu', '>= 12.04'
supports 'centos', '~> 6.5'

depends 'openssl'
depends 'postgresql'
