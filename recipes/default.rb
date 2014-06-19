#
# Cookbook Name:: dotpromo-postgresql-box
# Recipe:: node.default
#
# Copyright 2014, .PROMO Inc.
#
include_recipe 'openssl'
::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.default['postgresql']['password']['postgres'] = secure_password
node.default['postgresql']['version'] = '9.2'
node.default['postgresql']['dir'] = '/srv/db/postgresql'
node.default['postgresql']['pg_hba'] = [
  { type: 'local', db: 'all', user: 'postgres', addr: nil, method: 'ident' },
  { type: 'local', db: 'all', user: 'all', addr: nil, method: 'md5' },
  { type: 'host',  db: 'all', user: 'all', addr: '::1/128', method: 'md5' },
  { type: 'host',  db: 'all', user: 'all', addr: '127.0.0.1/32', method: 'md5' }
]
node.default['postgresql']['config_pgtune']['db_type'] = 'web'
node.default['postgresql']['config']['port'] = '5432'
node.default['postgresql']['config']['listen_addresses'] = 'localhost'
node.default['postgresql']['config']['log_filename'] = 'postgresql-%Y-%m-%d_%H%M%S.log'
node.default['postgresql']['config']['log_rotation_size'] = '10MB'
node.default['postgresql']['config']['log_rotation_age'] = '1d'
if platform_family?('rhel')
  node.default['postgresql']['enable_pgdg_yum'] = true
  node.default['postgresql']['enable_pgdg_apt'] = false
  node.default['postgresql']['client']['packages'] = ['postgresql92-devel']
  node.default['postgresql']['server']['packages'] = ['postgresql92-server']
  node.default['postgresql']['contrib']['packages'] = ['postgresql92-contrib']
  node.default['postgresql']['server']['service_name'] = "postgresql-#{node['postgresql']['version']}"
end
if platform_family?('debian')
  node.default['postgresql']['enable_pgdg_yum'] = false
  node.default['postgresql']['enable_pgdg_apt'] = true
  node.default['postgresql']['client']['packages'] = %w(postgresql-client-9.2 libpq-dev)
  node.default['postgresql']['server']['packages'] = ['postgresql-9.2']
  node.default['postgresql']['contrib']['packages'] = ['postgresql-contrib-9.2']
end
include_recipe 'postgresql::server'
include_recipe 'postgresql::contrib'
include_recipe 'postgresql::config_pgtune'
include_recipe 'postgresql::config_initdb'
include_recipe 'postgresql::ruby'
