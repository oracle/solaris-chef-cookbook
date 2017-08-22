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


actions :import, :export, :inventory, :validate,     :extract, :refresh,:revert,:setprop,
        :delprop,:addpg,  :delpg,     :addpropvalue, :delpropvalue, :delete
         
         
attribute :file_name, kind_of: String
attribute :fmri, kind_of: String
attribute :instance, kind_of: String
attribute :site_profile, kind_of: String
attribute :layers, kind_of: [TrueClass, FalseClass], default: false
attribute :masked, kind_of: [TrueClass, FalseClass], default: false
attribute :value, kind_of: String
attribute :new_value, kind_of: String
attribute :delete_service, kind_of: String
attribute :property_group, kind_of: String
attribute :property, kind_of: String
attribute :type, kind_of: String
attribute :layout, kind_of: String
attribute :pg_name, kind_of: String
attribute :globpattern, kind_of: String
attribute :environment, kind_of: String
attribute :method_name, kind_of: String
attribute :options, kind_of: Hash
attribute :application, kind_of: Hash 
attribute :type, kind_of: String
