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

actions :mediator
default_action :mediator

attribute :version, kind_of: String
attribute :no_be_activate, kind_of: [TrueClass, FalseClass], :default => false
attribute :no_backup_be, kind_of: [TrueClass, FalseClass], :default => false
attribute :deny_new_be, kind_of: [TrueClass, FalseClass], :default => false
attribute :require_new_be, kind_of: [TrueClass, FalseClass], :default => false
attribute :be_name, kind_of: [TrueClass, FalseClass], :default => false
attribute :bname, kind_of: String







