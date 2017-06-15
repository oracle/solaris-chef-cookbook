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

include Chef::Mixin::ShellOut

use_inline_resources

def load_current_resource
  @dladm = new_resource.class.new(new_resource.name)
  @dladm.link(new_resource.link)
  @dladm.vid(new_resource.vid)
  @dladm.interface(new_resource.interface)
  @dladm.temporary(new_resource.temporary)
  @dladm.force(new_resource.force)
  @dladm.new_linkname(new_resource.new_linkname)
  @dladm.options(new_resource.options)
  @dladm.protect(new_resource.protect)
  @dladm.name(new_resource.name)
  @dladm.mvalue(new_resource.mvalue)
  @dladm.slotid(new_resource.slotid)
  @dladm.iptype(new_resource.iptype)
  @dladm.prefix(new_resource.prefix)
  @dladm.vrid(new_resource.vrid)
  @dladm.vni(new_resource.vni)
  @dladm.ip_address(new_resource.ip_address)
  @dladm.vlan_id(new_resource.vlan_id)
  @dladm.forward_delay(new_resource.forward_delay)
  @dladm.linkbridge(new_resource.linkbridge)
  @dladm.bridge(new_resource.bridge)
end


action :create_bridge do
  flag = bridge_exists?(@dladm.name)
  unless flag ==0
    link_flags = ""
    @dladm.linkbridge.each do |key|
      temp = " -l #{key}"
      link_flags = link_flags + temp
    end
    @create_bridge ="dladm create-bridge -P #{@dladm.protect} -d #{@dladm.forward_delay}  #{link_flags}  #{@dladm.name}"
    Chef::Log.info(@create_bridge)
    shell_out!(@create_bridge)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("create-bridge  #{@dladm.name} Already exists")
  end
end

action :remove_bridge do
   flag = bridge_exists?(@dladm.name)
  unless flag ==1
    link_flags = ""
    @dladm.linkbridge.each do |key|
      temp = " -l #{key}"
      link_flags = link_flags + temp
    end
    @remove_bridge ="dladm remove-bridge #{link_flags}  #{@dladm.name}"
    Chef::Log.info(@remove_bridge)
    shell_out!(@remove_bridge)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Removing remove-bridge  #{@dladm.name} Already exists")
  end
end

action :delete_bridge do
  flag = bridge_exists?(@dladm.name)
  unless flag ==1 
    Chef::Log.info("Delete bridge instance #{@dladm.name}")
    @delete_bridge = ("dladm delete-bridge #{@dladm.name}")
    Chef::Log.info(@delete_bridge)
    shell_out!(@delete_bridge)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.fatal("Delete bridge instance #{@dladm.name} not available")
  end
end

action :rename_link do
  flag = dladm_rename? 
  unless flag ==0
    @rename_link = ("dladm rename-link #{@dladm.name} #{@dladm.new_linkname}")
    Chef::Log.info(@rename_link)
    shell_out!(@rename_link)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Renaming #{@dladm.name} not available")
  end
end


action :set_linkprop do
  @dladm.options.each do |key,val|
    property ="#{key}"
    value ="#{val}"
    @set_linkprop = ("dladm set-linkprop -p #{property}=#{value} #{@dladm.name}")
    Chef::Log.info(@set_linkprop)
    shell_out!(@set_linkprop)
    new_resource.updated_by_last_action(true)
  end
end

action :create_vnic do
  Chef::Log.info("dladm create-vnic #{@dladm.name}")
  flag =vnic_exists(@dladm.name)
  tmp_flag =""
  dladm_flags =""
  
  if flag ==1
    if (@dladm.temporary)
      tmp_flag = " -t"
      dladm_flags = tmp_flag
    end
    
    if (@dladm.mvalue)
      dladm_flags = tmp_flag + " -m #{@dladm.mvalue}"
      
      if (@dladm.slotid)
        dladm_flags =dladm_flags + " -s #{@dladm.slotid}"
      end
      
      if (@dladm.prefix)
        dladm_flags =dladm_flags + " -r #{@dladm.prefix}"
      end
      
      if (@dladm.vrid)
        dladm_flags =dladm_flags + " -V #{@dladm.vrid}"
      end
      if (@dladm.iptype)
        dladm_flags =dladm_flags + " -A #{@dladm.iptype}"
      end
    end
    
    @create_vnic="dladm create-vnic #{dladm_flags} -l #{@dladm.link} #{@dladm.name}"
    Chef::Log.info(@create_vnic)
    shell_out!(@create_vnic)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Creating Vnic #{@dladm.name}  already exists")
  end
end

action :delete_vnic do
  flag =vnic_exists(@dladm.name)
  if flag ==0
    @delete_vnic =("dladm delete-vnic #{@dladm.name}")
    Chef::Log.info(@delete_vnic)
    shell_out!(@delete_vnic)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Delete delete-vnic #{@dladm.name} object not found")
  end
end

action :modify_vnic do
  
  flag =vnic_exists(@dladm.name)
  dladm_flags =""
  if flag ==0
    
    if (@dladm.temporary)
      dladm_flags = " -t"
    end
    
    if (@dladm.mvalue)
      dladm_flags = dladm_flags +" -m #{@dladm.mvalue}"
      
      if (@dladm.slotid)
        dladm_flags = dladm_flags  + " -s #{@dladm.slotid}"
      end
      
      if (@dladm.prefix)
        dladm_flags = tmp_flag + " -r #{@dladm.prefix}"
      end
      
      if (@dladm.vrid)
        dladm_flags = dladm_flags + " -V #{@dladm.vrid}"
      end
      
      if (@dladm.iptype)
        dladm_flags = dladm_flags + " -A #{@dladm.iptype}"
      end
    end
    
    @modify_vnic="dladm modify-vnic #{dladm_flags} #{@dladm.name}"
    Chef::Log.info(@modify_vnic)
    shell_out!(@modify_vnic)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("modify-vnic #{@dladm.name} not available")
  end
end



action :create_vlan do
  flag = vlan_exists(@dladm.name)
  tmp_flag =""
  vlan_flags =""
  
  if flag ==1
    if (@dladm.temporary)
      tmp_flag =" -t"
      vlan_flags =tmp_flag
    end
    
    if (@dladm.force)
      tmp_flag = " -f"
      vlan_flags = vlan_flags + tmp_flag
    end
    
    if (@dladm.vid)
      tmp_flag = " -v #{@dladm.vid}"
      vlan_flags = vlan_flags + tmp_flag
    end 
 
 
    @create_vlan="dladm create-vlan -l #{@dladm.link} #{vlan_flags} #{@dladm.name}"
    Chef::Log.info(@create_vlan)
    shell_out!(@create_vlan)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Creating vlan #{@dladm.name},vlan already exists use delete-vlan to remove")
  end
end


action :delete_vlan do
  flag = vlan_exists(@dladm.name)
  vlan_flags = ""
  if flag ==0

    if (@dladm.temporary)
      vlan_flags =" -t"
    end

    @delete_vlan =("dladm delete-vlan #{vlan_flags} #{@dladm.name}")
    Chef::Log.info(@delete_vlan)
    shell_out! (@delete_vlan)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Delete VLAN  #{@dladm.name} is not available ")
  end
end


action :modify_vlan do
  
  flag = vlan_exists(@dladm.name)
  vlan_flags =""
  
  if flag ==0 

    if (@dladm.temporary)
      vlan_flags =" -t"
    end

    if (@dladm.force)
      vlan_flags = vlan_flags + " -f"
    end
  
    if (@dladm.vid)
      vlan_flags = vlan_flags + " -v #{@dladm.vid}"
    end
    
    @modify_vlan=("dladm modify-vlan #{vlan_flags} #{@dladm.name}")
    Chef::Log.info(@modify_vlan)
    shell_out!(@modify_vlan)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Modify vlan #{@dladm.name} already is not available")
  end
end


action :create_vxlan do
  
  flag = vxlan_exists(@dladm.name)
  if flag ==1
    
    vxlan_flags =""
    
    if (@dladm.temporary)
      vxlan_flags = " -t"
    end

    if (@dladm.ip_address && @dladm.vni && @dladm.interface) 
      Chef::Log.info("dladm ip_address and interface are mutually exclusive")
    end
    
    if (@dladm.ip_address && @dladm.vni)
      vxlan_flags = "-p addr=#{@dladm.ip_address},vni=#{@dladm.vni} "
    end

    if (@dladm.interface && @dladm.vni)
      vxlan_flags = "-p interface=#{@dladm.interface},vni=#{@dladm.vni}"
    end
    
    @create_vxlan=("dladm create-vxlan #{vxlan_flags} #{@dladm.name}")
    Chef::Log.info(@create_vxlan)
    shell_out!(@create_vxlan)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Already dladm #{@dladm.name} exists use delete-vxlan")
  end
end


action :delete_vxlan do
  flag = vxlan_exists(@dladm.name)
  if flag ==0
    vxlan_flags =""
    
    if (@dladm.temporary)
      vxlan_flags = " -t"
    end
    
    @delete_vxlan =("dladm delete-vxlan #{vxlan_flags} #{@dladm.name}")
    Chef::Log.info(@delete_vxlan)
    shell_out! (@delete_vxlan)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.fatal("Delete vxlan #{@dladm.name} is not available ")
  end
end


private
 
def bridge_exists?(bridge)
  cmd_out = shell_out("dladm show-bridge #{bridge}")
  cmd_out.exitstatus
end

def dladm_rename?
  cmd_out = shell_out("dladm show-phys #{@dladm.name}")
  cmd_out.exitstatus
end

def vnic_exists(vnic)
  cmd_out = shell_out ("dladm show-vnic  #{vnic}") 
  cmd_out.exitstatus
end

def vlan_exists(vlan)
  cmd_out = shell_out("dladm show-vlan #{vlan}")
  cmd_out.exitstatus
end

def vxlan_exists(vxlan)
  cmd_out = shell_out("dladm show-vxlan #{vxlan}")
  cmd_out.exitstatus
end
