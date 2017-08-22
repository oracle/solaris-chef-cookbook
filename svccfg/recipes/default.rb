##
## Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
## http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.


#remote_file '/var/tmp/test.xml' do
#  source 'http://tycoon.in.oracle.com/files/test.xml'
#  owner 'root'
#  group 'bin'
#  mode '0755'
#  action :create
#end
#
#svccfg 'first-boot' do
#  file_name "/var/tmp/test.xml"
#  action :import 
#end
#
#svccfg 'first-boot' do
#  fmri "svc:/site/first-boot"
#  file_name "test-out.xml"
#  action :export
#end


#svcadm 'first-boot' do
# action :disable
#end


#svccfg 'first-boot' do
# action :delete 
#end


#svccfg 'system-log' do
#   options ({'refresh/type' => 'method'})
#   action :setprop
#end

svccfg 'system-log' do
  property "tm_man_syslogd1M/section"        ## Changes for after the Mail to Pradhap
  type "count"                               
  value "90"         
  action :setprop
end


#svccfg 'system-log' do
#   options ({'refresh/timeout_seconds' => 'ttttt'})
#  action :delprop
#end
#
#
#svccfg 'system-log' do
#  options ({'test10' => 'application15'}) 
#  action :addpg
#end
#
#
#svccfg 'system-log' do
#  options ({'test10' => 'application5'})
#  action :delpg
#end
#
#
#svccfg 'system-log' do
#  options ({'config/ven' => 'true'})
#  type "boolean"
#  action :addpropvalue
#end

##########################################
## For checking property & property_type##

##########################################

#  svccfg -s system-log addpropvalue config/ven boolean: true
# svccfg -s my-svc:default addpropvalue config/vendor astring: vendorb


#svccfg 'system-log' do
#  property      "config/veen"
#  property_type "astring"                  # string, number, boolean
#  value ""
#  action :addpropvalue
#end



#svccfg 'system-log' do
#  options ({'config/ven' => 'application5'})
#  action :delpropvalue
#end
