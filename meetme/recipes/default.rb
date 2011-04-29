#
# Cookbook Name:: meetme 
# Recipe:: default
#
# Copyright 2011, Dominique Broeglin
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

RVM_RUBY = "jruby-1.6.1"

include_recipe "build-essential"
include_recipe "java"

%w(curl git-core).each do |pkg|
  package pkg
end

file "/home/vagrant/.gemrc" do
  content 'gem: --no-rdoc --no-ri'
  mode "600"
  owner "vagrant"
end

bash "install RVM" do
  user "root"
  code "bash < <( curl -L https://rvm.beginrescueend.com/install/rvm )" 
end

bash "install #{RVM_RUBY}" do
  user "root"
  code <<-EOH
   (
    echo Installing jruby
    source /usr/local/rvm/scripts/rvm
    rvm install #{RVM_RUBY} 2>&1 
    rvm use #{RVM_RUBY} 2>&1 
    rvm gemset create meetme
    rvm gemset use meetme
    gem install bundler mizuno 2>&1 
   ) 2>&1 | logger
  EOH
  not_if { File.exists?("/usr/local/rvm/rubies/#{RVM_RUBY}") }
end
