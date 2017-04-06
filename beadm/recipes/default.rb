#
# Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
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
#
# Cookbook Name:: beadm
# Recipe:: default
#


#beadm 'newbe' do
#        action :destroy
#end


#beadm 'newbe2' do
#        action :create
#end

#beadm 'testbe' do
#        action :rename
#	new_be "testing"
#end

#beadm 'newbe2' do
#  options ({
#             'recordsize' => '128K', 'compression' => 'on'
#           })
#  action :create
#end

beadm 'newbe2' do
  mountpoint "/mnt"
  action :mount
end

#beadm 'newbe2' do
#  action :umount
#end
#

#beadm 'newbe*' do
#	action :destroy_pattern
#end

