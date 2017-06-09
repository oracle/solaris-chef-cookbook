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

def load_current_resource
  @ipadm = new_resource.class.new(new_resource.name)
  @ipadm.name(new_resource.name)
  @ipadm.addresstype(new_resource.addresstype)
  @ipadm.ipaddress(new_resource.ipaddress)
  @ipadm.temporary(new_resource.temporary)
  @ipadm.inform(new_resource.inform)
  @ipadm.options(new_resource.options)
  @ipadm.property(new_resource.property)
end


action :create_ip do
  ipadm_flags = ""
  flag =ip_exists?
  
  if (@ipadm.temporary)
    ipadm_flags = "-t"
  end
  
  unless flag == 0
    Chef::Log.info("create the IP interface #{ipadm_flags} #{@ipadm.name}")
    @create_ip = ("ipadm create-ip #{ipadm_flags} #{@ipadm.name}")
    Chef::Log.info(@create_ip)
    shell_out!(@create_ip)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("IP interface #{@ipadm.name} already exists ipadm returned with #{flag}")
  end
end


action :delete_ip do
  flag = ip_exists?
  if flag ==0
    Chef::Log.info("Delete IP interface #{@ipadm.name}")
    @delete_ip = ("ipadm delete-ip  #{@ipadm.name}")
    Chef::Log.info(@delete_ip)
    shell_out!(@delete_ip)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Delete IP interface #{@ipadm.name} doesn't exists ipadm returned with #{flag}")
  end
end


action :create_addr do 
  flag = info?
  ipadm_flags = ""
  if flag == 1
    
    if (@ipadm.temporary) 
      ipadm_flags = "-t"
    end
    
    if (@ipadm.addresstype)
      ipadm_flags = ipadm_flags + " -T " +@ipadm.addresstype
    end
    
    if (@ipadm.ipaddress !="" && @ipadm.addresstype != "dhcp")
      ipadm_flags = ipadm_flags + " -a #{@ipadm.ipaddress} "
    end
    
    Chef::Log.info("To configure an IP address #{ipadm_flags} #{@ipadm.name}")
    @ipadm_create="ipadm create-addr #{ipadm_flags} #{@ipadm.name}"
    Chef::Log.info(@ipadm_create)
    shell_out!(@ipadm_create)
    new_resource.updated_by_last_action(true)
  end
  
  if flag == 0
    Chef::Log.info("Configure an IP address #{@ipadm.name} #{@ipadm.ipaddress} is same as already set address")
  end 
  
  if flag == 2
    Chef::Log.info("Configure an IP address #{@ipadm.name} #{@ipadm.ipaddress} failed, use delete-addr and re-try")
  end
end


action :delete_addr do
  flag = addrobj_exists?
  if flag==0
    Chef::Log.info("Destroying the ipadm #{@ipadm.name}")
    @ipadm_delete=("ipadm delete-addr #{@ipadm.name}")
    Chef::Log.info(@ipadm_delete)
    shell_out!(@ipadm_delete)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("ADDROBJ ipadm #{@ipadm.name} doesn't exists ipadm returned with #{flag}")
  end
end


action :disable_addr do
  flag =addr?
  
  if flag == 5
    Chef::Log.info("Ipadm #{@ipadm.name} already status is disabled")
  else
    Chef::Log.info("Disabling the address -t #{@ipadm.name}")
    @disable = "ipadm disable-addr -t #{@ipadm.name}"
    Chef::Log.info(@disable)
    shell_out!(@disable)
    new_resource.updated_by_last_action(true)
  end
end


action :enable_addr do
  
  flag =addr?
  
  if flag==1
    Chef::Log.info("Already address #{@ipadm.name} already is enabled")
  else
    Chef::Log.info("Enabling the address -t #{@ipadm.name}")
    @enable ="ipadm enable-addr -t #{@ipadm.name}"
    Chef::Log.info(@enable)
    shell_out!(@enable)
    new_resource.updated_by_last_action(true)
  end 
end


action :down_addr do
  
  flag =addr?
  ipadm_flags = ""
  
  if @ipadm.temporary
    ipadm_flags =  "-t"
  end
  
  if flag==4
    Chef::Log.info("Already address #{@ipadm.name} is down")
  else
    Chef::Log.info("Down the address #{ipadm_flags}  #{@ipadm.name}")
    @down = "ipadm down-addr #{ipadm_flags}  #{@ipadm.name}"
    Chef::Log.info(@down)
    shell_out!(@down)
    new_resource.updated_by_last_action(true)
  end
end


action :up_addr do
  
  flag =addr?
  
  ipadm_flags = ""
  
  if @ipadm.temporary
    ipadm_flags =  "-t"
  end
  
  if flag == 1
    Chef::Log.info("Already address #{@ipadm.name} is UP")
  else
    Chef::Log.info("Enabing address #{ipadm_flags} #{@ipadm.name}")
    @up_addr = "ipadm up-addr #{ipadm_flags} #{@ipadm.name}"
    Chef::Log.info(@up_addr)
    shell_out!(@up_addr)
    new_resource.updated_by_last_action(true)
  end
end


action :refresh do
  
  ipadm_flags = ""
  
  if @ipadm.inform
    ipadm_flags =  "-i"
  end
  
  Chef::Log.info("Refresh the  addresses #{ipadm_flags} #{@ipadm.name}")
  @refresh = "ipadm refresh-addr #{ipadm_flags} #{@ipadm.name}"
  Chef::Log.info(@refresh)
  shell_out! (@refresh)
  new_resource.updated_by_last_action(true)
end

action :disable_if do
  
  flag= if_check?
  if flag!=5
    Chef::Log.info("Disable an IP interface -t #{@ipadm.name}")
    @disable = "ipadm disable-if -t #{@ipadm.name}"
    Chef::Log.info(@disable)
    shell_out!(@disable)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Already Ipadm #{@ipadm.name} is disabled")
  end
end


action :enable_if do
  flag= if_check?
  if flag != 1 
    Chef::Log.info("Enable an IP interface -t #{@ipadm.name}")
    @enable ="ipadm enable-if -t #{@ipadm.name}"
    Chef::Log.info(@enable)
    shell_out!(@enable)
    new_resource.updated_by_last_action(true)
  else
    Chef::Log.info("Already Ipadm #{@ipadm.name} is enabled")
  end
end


action :set_addrprop do
  
  flag = addrobj_exists?
  unless flag ==1
    ipadm_flags = ""
    
    @ipadm.options.each do |key,val| 
      property = "#{key}"
      value = "#{val}"
      ipadm_flags = "-p #{property}=#{value}"
    end
    
    Chef::Log.info("Ipadm set-addrprop #{ipadm_flags}  #{@ipadm.name}")
    @setrprop=("ipadm set-addrprop  #{ipadm_flags}  #{@ipadm.name}")
    Chef::Log.info(@setrprop)
    shell_out!(@setrprop)
  else
    Chef::Log.info("ipadm #{@ipadm.name} is not available")
  end
end


action :reset_addrprop do    
  
  flag = addrobj_exists?
  unless flag ==1
    
    ipadm_flags = ""
    
    if @ipadm.temporary 
      ipadm_flags = "-t"  
    end
    
    Chef::Log.info("Reset an addrobj's property value #{ipadm_flags} -p #{@ipadm.property} #{@ipadm.name}")
    @resetrprop=("ipadm reset-addrprop  #{ipadm_flags} -p #{@ipadm.property} #{@ipadm.name}")
    Chef::Log.info(@resetrprop)
    shell_out!(@resetrprop)
  else
    Chef::Log.info("ipadm #{@ipadm.name} is not available")
  end
end


private

def info?
  Chef::Log.info("Checking info ipadm list #{@ipadm.name}") 
  flag = -1
  cmd_out = shell_out("ipadm show-addr -p -o ADDR  #{@ipadm.name}")
  flag = cmd_out.exitstatus
  if cmd_out.exitstatus == 0
    Chef::Log.info("Current ipadm show-addr #{cmd_out.stdout.chomp}") 
    curr_address = cmd_out.stdout.chomp
    if curr_address == @ipadm.ipaddress 
      flag = 0
    else
      flag = 2
    end
  end
  flag
end

def addrobj_exists?
  Chef::Log.info("Checking info ipadm show-addr #{@ipadm.name}")
  cmd_out = shell_out("ipadm show-addr -p -o ADDROBJ #{@ipadm.name}")
  new_resource.updated_by_last_action(true)
  cmd_out.exitstatus
end

def ip_exists?
  cmd_out = shell_out("ipadm show-if #{@ipadm.name}")
  cmd_out.exitstatus
end

def if_check?
  Chef::Log.info("Check if addrobj already Enable/Disable")
  cmd_out = shell_out ("ipadm show-if -p -o STATE #{@ipadm.name}")
  flag = cmd_out.exitstatus
  if cmd_out.exitstatus == 0
    status = cmd_out.stdout.chomp
    flag = if_status(status)
  else
    flag = 1
    Chef::Log.info("Failed to determine ipadm show-if -p -o STATE #{@ipadm.name}")
    raise "Failed to determine ipadm show-if -p -o STATE #{@ipadm.name}"
  end  
  flag 
end

def addr?
  Chef::Log.info("Check the current status of addrobj STATE")
  flag = -1
  cmd_out = shell_out ("ipadm show-addr -p -o STATE #{@ipadm.name}")
  new_resource.updated_by_last_action(true)
  flag = cmd_out.exitstatus
  if cmd_out.exitstatus == 0
    status = cmd_out.stdout.chomp
    flag = ipadm_status(status)
  else
    flag = 1
    Chef::Log.info("Failed to determine ipadm show-addr -p -o STATE #{@ipadm.name}")
    raise "Failed to determine ipadm show-addr -p -o STATE #{@ipadm.name}"
  end  
  flag 
end

def ipadm_status(curr_status)
  flag = -1
  if curr_status == "ok"
    flag = 1
  end
  if curr_status == "offline"
    flag = 2
  end
  if curr_status == "failed"
    flag = 3
  end
  if curr_status == "down"
    flag = 4
  end
  if curr_status == "disabled"
    flag = 5
  end
  flag
end


def if_status(curr_status)
  flag = -1
  if curr_status == "ok"
    flag = 1
  end
  if curr_status == "disabled"
    flag = 5
  end
  flag
end
