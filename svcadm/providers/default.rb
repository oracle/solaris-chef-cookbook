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
  @svcadm = new_resource.class.new(new_resource.name) 
  @svcadm.service_instance(new_resource.service_instance)
  @svcadm.enable(new_resource.enable)
  @svcadm.name(new_resource.name)
  @svcadm.temporary(new_resource.temporary)
  @svcadm.service(new_resource.service)
  @svcadm.state(new_resource.state)
  @svcadm.recursive(new_resource.recursive)
  @svcadm.default(new_resource.default)
end


action :enable do
  Chef::Log.info("svcadm enable #{@svcadm.name}")
  flag = service_exists?
  
  if flag ==14
    Chef::Log.info("svcadm  #{@svcadm.name} Already enable ")
    
  else
    Chef::Log.info("svcadm enable #{@svcadm.name}")
    svcadm_flags = ""
    
    if (@svcadm.recursive )
      svcadm_flags = svcadm_flags + " -r"
    end
    
    if (@svcadm.temporary)
      svcadm_flags = svcadm_flags + " -t"
    end
    
    if (@svcadm.service)
      svcadm_flags = svcadm_flags + " -s"
    end
    
    @enable_svcadm=("svcadm enable #{svcadm_flags} #{@svcadm.name}")
    Chef::Log.info(@enable_svcadm)
    shell_out!(@enable_svcadm)
  end
end


action :disable do
  Chef::Log.info("svcadm disable #{@svcadm.name}")
  flag = service_exists?
  if flag ==15
    Chef::Log.info("svcadm  #{@svcadm.name} is already Disabled")
    
  else
    Chef::Log.info("svcadm disable #{@svcadm.name}")
    svcadm_flags = ""
    
    if (@svcadm.temporary)
      svcadm_flags = svcadm_flags + " -t"
    end
    
    if (@svcadm.service )
      svcadm_flags = svcadm_flags + " -s"
    end
    
    @disable_svcadm=("svcadm disable #{svcadm_flags} #{@svcadm.name}")
    Chef::Log.info(@disable_svcadm)
    shell_out!(@disable_svcadm)
  end
end


action :restart do
  Chef::Log.info("svcadm restart #{@svcadm.name}")
  flag = instance_exists?
  unless flag ==1
    
    svcadm_flags = ""
    
    if (@svcadm.service )
      svcadm_flags = svcadm_flags + " -s"
    end
    
    @restart_svcadm=("svcadm restart #{svcadm_flags} #{@svcadm.name}")
    Chef::Log.info(@restart_svcadm)
    shell_out!(@restart_svcadm)
  else
    Chef::Log.info("svcadm  #{@svcadm.name} is not available")
    raise ("svcadm  #{@svcadm.name} is not available")
  end
end


action :refresh do
  Chef::Log.info("svcadm refresh #{@svcadm.name}")
  flag = instance_exists?
  unless flag ==1
    svcadm_flags = ""
    
    if (@svcadm.service )
      svcadm_flags = svcadm_flags + " -s"
    end
    
    @refresh_svcadm=("svcadm refresh #{svcadm_flags} #{@svcadm.name}")
    Chef::Log.info(@refresh_svcadm)
    shell_out!(@refresh_svcadm)
  else
    Chef::Log.info("svcadm  #{@svcadm.name} is not available")
    raise ("svcadm  #{@svcadm.name} is not available")
  end
end


action :mark do
  Chef::Log.info("svcadm mark #{@svcadm.name}")
  flag = service_exists?
  
  if flag ==13
    Chef::Log.info("svcadm  #{@svcadm.name} state Already Maintenance ")
    
  else
    svcadm_flags = ""
    
    if (@svcadm.state == "maintenance" )
      svcadm_flags = svcadm_flags + " -It"
    end
    
    if (@svcadm.state == "degraded" )
      svcadm_flags = svcadm_flags + " -I"
    end
    
    if (@svcadm.service )
      svcadm_flags = svcadm_flags + " -s"
    end
    
    @mark_svcadm=("svcadm mark  #{svcadm_flags} #{@svcadm.state} #{@svcadm.name}")
    Chef::Log.info(@mark_svcadm)
    shell_out!(@mark_svcadm)
  end
end


action :clear do
  Chef::Log.info("svcadm clear #{@svcadm.name}")
  flag = instance_exists?
  unless flag ==1
    svcadm_flags = ""
    
    if (@svcadm.service )
      svcadm_flags = svcadm_flags + " -s"
    end
    
    
    @clear_svcadm=("svcadm clear  #{svcadm_flags} #{@svcadm.name}")
    Chef::Log.info(@clear_svcadm)
    shell_out!(@clear_svcadm)
  else
    Chef::Log.info("svcadm  #{@svcadm.name} is not available")
    raise ("svcadm  #{@svcadm.name} is not available")
  end
end


private

def service_exists?
  Chef::Log.info("Check if svcadm already existing")
  cmd_out = shell_out("svcs -H -o state #{@svcadm.name}")
  new_resource.updated_by_last_action(true)
  flag = cmd_out.exitstatus
  if cmd_out.exitstatus ==0
    status = cmd_out.stdout.chomp
    flag = svcadm_status(status)
  else
    flag =1
    Chef::Log.info("Failed to determine svcadm svcs -H -o state #{@svcadm.name}")
    raise "Failed to determine svcadm svcs -H -o state #{@svcadm.name}"
  end
  flag
end

def svcadm_status(curr_status)
  flag = -1
  if curr_status == "maintenance"
    flag = 13
  end
  if curr_status == "online"
    flag = 14
  end
  if curr_status == "disabled"
    flag = 15
  end
  flag
end

def instance_exists?
  Chef::Log.info("Check if Instance already existing")
  cmd_out = shell_out("svcs -p #{@svcadm.name}")
  cmd_out.exitstatus
end