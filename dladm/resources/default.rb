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


actions :create_bridge, :remove_bridge, :delete_bridge, :rename_link , :set_linkprop,:create_vnic, :delete_vnic, :modify_vnic, :create_vlan, :delete_vlan, 
         :modify_vlan, :create_vxlan, :delete_vxlan, :create_bridge, :delete_bridge, :remove_bridge

attribute :old_linkname, kind_of: String
attribute :new_linkname, kind_of: String
attribute :temporary, kind_of: [TrueClass, FalseClass], :default => false 
attribute :vid, kind_of: String
attribute :name, kind_of: String
attribute :interface, kind_of: String
attribute :mtu, kind_of: String
attribute :link, kind_of: String
attribute :vlan_link, kind_of: String
attribute :force, kind_of: [TrueClass, FalseClass], :default => false 
attribute :mvalue, kind_of: String
attribute :prefix, kind_of: String
attribute :cpus, kind_of: String
attribute :options, kind_of: Hash
attribute :bridge_link, kind_of: String
attribute :protect, kind_of: String
attribute :vrid, kind_of: String
attribute :slotid, kind_of: String
attribute :iptype, kind_of: String
attribute :vni, kind_of: String
attribute :interface, kind_of: String
attribute :ip_address, kind_of: String
attribute :vlan_id, kind_of: String
attribute :forward_delay, kind_of: String
attribute :linkbridge, kind_of: Array
attribute :bridge, kind_of: String
