#
# Cookbook Name:: dotpromo-postgresql-box
# Recipe:: default
#
# Copyright 2014, .PROMO Inc.
#
include_recipe 'openssl'

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['postgresql']['password']['postgres'] = secure_password
node.set['postgresql']['version'] = '9.3'
node.set['postgresql']['dir'] = '/srv/db/postgresql'
node.set['postgresql']['pg_hba'] = [
  { type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'ident' },
  { type: 'local', db: 'all', user: 'all', addr: nil, method: 'md5' },
  { type: 'host',  db: 'all', user: 'all', addr: '::1/128', method: 'md5' },
  { type: 'host',  db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'md5' }
]
node.set['postgresql']['config_pgtune']['db_type'] = 'web'
node.set['postgresql']['config']['port'] = '5432'
node.set['postgresql']['config']['listen_addresses'] = 'localhost'
node.set['postgresql']['config']['log_filename'] = 'postgresql-%Y-%m-%d_%H%M%S.log'
node.set['postgresql']['config']['log_rotation_size'] = '10MB'
node.set['postgresql']['config']['log_rotation_age'] = '1d'
node.set['postgresql']['enable_pgdg_yum'] = true if platform_family?('rhel')
node.set['postgresql']['enable_pgdg_apt'] = true if platform_family?('debian')
# workaround for reload attributes from postgresql cookbook after we set postgresql version
node.from_file(run_context.resolve_attribute('postgresql', 'default'))

include_recipe 'postgresql::server'
include_recipe 'postgresql::contrib'
include_recipe 'postgresql::config_pgtune'
include_recipe 'postgresql::config_initdb'
include_recipe 'postgresql::ruby'
