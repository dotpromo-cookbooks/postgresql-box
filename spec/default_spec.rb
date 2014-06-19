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
    %w(libpq-dev postgresql-9.2 postgresql-contrib-9.2 postgresql-client-9.2).each do |k|
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
    %w(postgresql92-devel postgresql92-server postgresql92-contrib).each do |k|
      it "installs #{k}" do
        expect(chef_run).to install_package(k)
      end
    end
  end
end
