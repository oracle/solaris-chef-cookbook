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
  @beadm = new_resource.class.new(new_resource.name)
  @beadm.name(new_resource.name)
  @beadm.options(new_resource.options)
  @beadm.mountpoint(new_resource.mountpoint)
  @beadm.new_be(new_resource.new_be)
  @beadm.info(info?)
  @beadm.list(list?)
  @beadm.current_props(current_props?)
end



action :create do
  unless created?
    Chef::Log.info("Creating beadm #{@beadm.name}")
    beadm_options = ""
    if (@beadm.options.empty?) 
    	Chef::Log.info("beadm options not passed")
    else
    	Chef::Log.info("beadm options passed")
      @beadm.options.each do |key,val|
        tmp = "-o #{key}=#{val} "
        beadm_options = beadm_options + tmp
      end
    end

    shell_out!("beadm create #{@beadm.name}")
    
    if @beadm.activate == true
      shell_out!("beadm activate #{@beadm.name}")
    end
    # update properties for new zfs
    @beadm.info(info?)
    @beadm.current_props(current_props?)

    new_resource.updated_by_last_action(true)
  end

end

action :destroy do
  if created?
    Chef::Log.info("Destroying beadm with beadm destroy -F #{@beadm.name}")
    shell_out!("beadm destroy -F #{@beadm.name}")
    new_resource.updated_by_last_action(true)
  end
end

action :destroy_pattern do
    Chef::Log.info("Destroying beadm with #{@beadm.name}")
  prop_hash = {}
  @beadm.list.stdout.split("\n").each do |line|
    l = line.split(';');
    prop_hash[l[0]] = line
  end
  prop_hash.each do |key, array|
      bename = key
      if ( bename =~ /#{@beadm.name}/ )
        shell_out!("beadm destroy -F #{key}")
        new_resource.updated_by_last_action(true)
      end
  end
end


action :activate do
  if created?
    Chef::Log.info("Activate beadm with beadm activate #{@beadm.name}")
    shell_out!("beadm activate #{@beadm.name}")
    new_resource.updated_by_last_action(true)
  end
end

action :beadm_publisher_set do
  if created?
    Chef::Log.info("Mount beadm with beadm mount #{@beadm.name}")
    shell_out!("beadm activate #{@beadm.name}")
    new_resource.updated_by_last_action(true)
  end
end

action :mount do
flag = -1 
  if created?
	current_be_props = @beadm.current_props[@beadm.name]
    tmp = current_be_props.split(';');
    if tmp[3] == @beadm.mountpoint 
    	Chef::Log.info("BE already mounted in #{tmp[3]}")
		flag = 0
	else 
    	if tmp[3] != @beadm.mountpoint && tmp[3] != ''
    		Chef::Log.info("BE already mounted. Unmount #{tmp[3]}")
			flag = 1
			raise "BE #{@beadm.name} is already mounted in #{tmp[3]}. Please unmount before proceeding."
   		else	 
    		Chef::Log.info("Mount #{@beadm.name} with mountpoint #{@beadm.mountpoint}")
    		status = shell_out!("beadm mount #{@beadm.name} #{@beadm.mountpoint}")
			flag = status.exitstatus
    		new_resource.updated_by_last_action(true)
		end
  	end
  end
	
	Chef::Log.info("Mount return value #{flag}")
	flag 
end

action :umount do
  if created?
    unless already_mounted?
    Chef::Log.info("Umount beadm with beadm umount #{@beadm.name}")
    shell_out!("beadm umount #{@beadm.name}")
    new_resource.updated_by_last_action(true)
    end
  end
end

action :rename do
  if created?
    Chef::Log.info("Renaming beadm #{@beadm.name} to #{@beadm.new_be}")
    shell_out!("beadm rename #{@beadm.name} #{@beadm.new_be}")
    new_resource.updated_by_last_action(true)
  end
end


private

def created?
  Chef::Log.info("Checking beadm already created")
  flag = @beadm.info.exitstatus.zero?
  if node['platform_version'] == '5.11'
    if @beadm.info.stdout.lines.count == 0
      flag = false
    end
  end
  flag
end

def current_props?
  prop_hash = {}
  @beadm.info.stdout.split("\n").each do |line|
    l = line.split(';');
    prop_hash[l[0]] = line
  end
  prop_hash
end

def info?
  Chef::Log.info("Checking info beadm list -H #{@beadm.name}")
  shell_out("beadm list -H #{@beadm.name}")
end

def list?
  Chef::Log.info("Checking beadm list -H")
  shell_out("beadm list -H")
end

def already_mounted?
  @beadm.current_props(current_props?)  
  current_be_props = @beadm.current_props[@beadm.name]
  tmp = current_be_props.split(';');
  flag = false
  if tmp[3] != ""
    Chef::Log.info("BE already mounted in #{tmp[3]}")
    flag = true
  end
  flag
end
