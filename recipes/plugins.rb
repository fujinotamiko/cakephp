node['cakephp']['plugins'].each do |name, attr|
	log attr
	git "/var/www/#{node['cakephp']['app_name']}/app/Plugin/#{attr['name']}" do
		user "root"
		group "root"
		repository "#{attr['repo_uri']}"
		reference "#{attr['reference']}"
		action :checkout
	end
end
