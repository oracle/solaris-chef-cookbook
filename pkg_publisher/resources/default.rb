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


actions :create, :destroy 

attribute :publisher, kind_of: String
attribute :type, kind_of: String, equal_to: ['mirror', 'origin'],default:'origin'
attribute :uri, kind_of: String
attribute :root, kind_of: String
attribute :sticky, kind_of: [TrueClass, FalseClass], :default => false
attribute :non_sticky, kind_of: [TrueClass, FalseClass], :default => false
attribute :search_before, kind_of: String
attribute :search_after, kind_of: String
attribute :ssl_cert, kind_of: String
attribute :ssl_key, kind_of: String
attribute :enable, kind_of: [TrueClass, FalseClass], :default => false
attribute :disable, kind_of: [TrueClass, FalseClass], :default => false
attribute :proxy, kind_of: String
attribute :syspub, kind_of: [TrueClass, FalseClass], :default => true

attribute :info, kind_of: Integer
attribute :list, kind_of: Mixlib::ShellOut, default: nil
attribute :current_props, kind_of: Array, default: nil

def initialize(*args)
  super
  @action = :create
end
