#
# Cookbook Name:: cakephp
# Recipe:: default
#
# Copyright 2013, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

git "/var/www/#{node['cakephp']['app_name']}" do
	user "apache"
	group "root"
	repository "https://github.com/cakephp/cakephp.git"
	reference "refs/tags/2.3.2"
	action :checkout
end
