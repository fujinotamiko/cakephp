#
# Cookbook Name:: cakephp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/var/www/#{node['cakephp']['app_name']}" do
	user "root"
	group "root"
	repository "https://github.com/cakephp/cakephp.git"
	reference "refs/tags/2.3.2"
	action :checkout
end

%w{
	database.php
	core.php
	routes.php
	bootstrap.php
}.each do |tempalate_name|
	template "/var/www/#{node['cakephp']['app_name']}/app/Config/#{tempalate_name}" do
		source "#{tempalate_name}.#{node['cakephp']['version']}.erb"
		mode "0664"
		variables(
			:security_salt => "#{node['cakephp']['Security']['salt']}",
			:security_cipher_seed => "#{node['cakephp']['Security']['cipherSeed']}",
			:datasource => "#{node['cakephp']['datasource']['default']}",
			:host => "#{node['cakephp']['datasource']['host']}",
			:username => "#{node['cakephp']['datasource']['username']}",
			:password => "#{node['cakephp']['datasource']['password']}",
			:database_name => "#{node['cakephp']['app_name']}",
			:port => "#{node['cakephp']['datasource']['port']}",
		)
	end
end

service "httpd" do
	supports :status => true, :restart => true, :reload => true
	action [ :enable, :start ]
end

template "/etc/httpd/conf.d/cakephp.conf" do
	source "httpd_vhost.conf.erb"
	mode "0664"
	notifies :reload, 'service[httpd]'
end
