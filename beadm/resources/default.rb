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

actions :create, :destroy, :activate, :destroy_pattern,:mount,:umount,:rename

attribute :name, kind_of: String
attribute :new_be, kind_of: String
attribute :mountpoint, kind_of: String, default: nil

#zfs properties
attribute :recordsize, kind_of: String, default: '128K'
attribute :atime, kind_of: String, equal_to: %w(on off), default: 'on'
attribute :compression, kind_of: String, equal_to: ['on', 'off', 'lzjb', 'gzip', 'gzip-1', 'gzip-2', 'gzip-3', 'gzip-4', 'gzip-5', 'gzip-6', 'gzip-7', 'gzip-8', 'gzip-9', 'lz4'], default: 'off'
attribute :quota, kind_of: String, default: 'none'
attribute :refquota, kind_of: String, default: 'none'
attribute :reservation, kind_of: String, default: 'none'
attribute :refreservation, kind_of: String, default: 'none'
attribute :dedup, kind_of: String, equal_to: %w(on off), default: 'off'
attribute :options, kind_of: Hash, default: {}

attribute :activate, kind_of: [TrueClass, FalseClass], :default => true
attribute :info, kind_of: Mixlib::ShellOut, default: nil
attribute :list, kind_of: Mixlib::ShellOut, default: nil
attribute :current_props, kind_of: Hash, default: nil
attribute :desired_props, kind_of: Hash, default: nil

def initialize(*args)
  super
  @action = :create
end
