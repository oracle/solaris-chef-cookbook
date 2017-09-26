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

actions :change_facet, :change_backup
default_action :change_facet

attribute :facet_value, kind_of: [TrueClass, FalseClass], default: true
attribute :mediation, kind_of: [TrueClass, FalseClass], default: false
attribute :request_operation, kind_of: String
attribute :accept, kind_of: [TrueClass, FalseClass], default: false
attribute :operation, kind_of: String
attribute :path_or_uri, kind_of: String
attribute :no_be_activate, kind_of: [TrueClass, FalseClass], default: false
attribute :no_index, kind_of: [TrueClass, FalseClass], default:   false
attribute :no_refresh, kind_of: [TrueClass, FalseClass], default: false
attribute :no_backup_be, kind_of: [TrueClass, FalseClass], default: false
attribute :backup_name, kind_of: String
attribute :backup_be_name, kind_of: [TrueClass, FalseClass], default: false
attribute :require_backup_be, kind_of: [TrueClass, FalseClass], default: false 
attribute :deny_new_be, kind_of: [TrueClass, FalseClass], default:  false  
attribute :be_name, kind_of: [TrueClass, FalseClass], default: false
attribute :bname, kind_of: String
attribute :reject, kind_of: [TrueClass, FalseClass], default: false
attribute :pkg_fmri_pattern, kind_of: String
attribute :sync_actuators, kind_of: [TrueClass, FalseClass], default: false
attribute :timeout, kind_of: Integer
attribute :require_new_be, kind_of: [TrueClass, FalseClass], default: false
attribute :sync_actuators_timeout, kind_of: [TrueClass, FalseClass], default: false
attribute :path_uri, kind_of: [TrueClass, FalseClass], default: false 
