require 'minitest/spec'
require 'minitest-chef-handler'
describe_recipe 'dotpromo-postgresql-box::default' do
  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources
  describe 'users and groups' do
    it 'creates a deployer user' do
      user('postgres').must_exist
    end
    it 'creates a deployer group' do
      group('postgres').must_exist
    end
  end
  describe 'folders' do
    it 'should create /srv/db/postgresql' do
      directory('/srv/db/postgresql').must_exist.with(:owner, 'postgres')
    end
  end
end
