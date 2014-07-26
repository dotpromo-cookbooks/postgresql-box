describe 'dotpromo-postgresql-box::default' do
  let(:chef_instance) do
    ChefSpec::Runner.new do |node|
      node.automatic['memory']['total'] = '1024Mb'
    end
  end
  let(:chef_run) do
    chef_instance.converge(described_recipe)
  end

  %w(openssl postgresql::client postgresql::server postgresql::config_pgtune postgresql::config_initdb).each do |k|
    it "includes the `#{k}` recipe" do
      expect(chef_run).to include_recipe(k)
    end
  end
  context 'ubuntu' do
    let(:chef_instance) do
      ChefSpec::Runner.new(platform: 'ubuntu', version: '12.04') do |node|
        node.automatic['memory']['total'] = '1024Mb'
      end
    end
    %w(libpq-dev postgresql-9.3 postgresql-contrib-9.3 postgresql-client-9.3).each do |k|
      it "installs #{k}" do
        expect(chef_run).to install_package(k)
      end
    end
  end
  context 'centos' do
    let(:chef_instance) do
      ChefSpec::Runner.new(platform: 'centos', version: '6.5') do |node|
        node.automatic['memory']['total'] = '1024Mb'
      end
    end
    %w(postgresql93-devel postgresql93-server postgresql93-contrib).each do |k|
      it "installs #{k}" do
        expect(chef_run).to install_package(k)
      end
    end
  end
end
