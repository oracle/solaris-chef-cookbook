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

include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @pkg_facet = Chef::Resource.resource_for_node(new_resource.declared_type, run_context.node).new(new_resource.name)
  @pkg_facet.name(new_resource.name)
  @pkg_facet.facet_value(new_resource.facet_value)
  @pkg_facet.request_operation(new_resource.request_operation)
  @pkg_facet.accept(new_resource.accept)
  @pkg_facet.path_or_uri(new_resource.path_or_uri)
  @pkg_facet.no_be_activate(new_resource.no_be_activate)
  @pkg_facet.no_index(new_resource.no_index)
  @pkg_facet.no_refresh(new_resource.no_refresh)
  @pkg_facet.no_backup_be(new_resource.no_backup_be)
  @pkg_facet.require_backup_be(new_resource.require_backup_be)
  @pkg_facet.backup_be_name(new_resource.backup_be_name)
  @pkg_facet.backup_name(new_resource.backup_name)
  @pkg_facet.deny_new_be(new_resource.deny_new_be)
  @pkg_facet.be_name(new_resource.be_name)
  @pkg_facet.bname(new_resource.bname)
  @pkg_facet.reject(new_resource.reject)
  @pkg_facet.pkg_fmri_pattern(new_resource.pkg_fmri_pattern)
  @pkg_facet.sync_actuators(new_resource.sync_actuators)
  @pkg_facet.require_new_be(new_resource.require_new_be)
  @pkg_facet.timeout(new_resource.timeout)
  @pkg_facet.sync_actuators_timeout(new_resource.sync_actuators_timeout)
end


action :change_facet do
  pkg_flags =""
  
  flag = facet_status?
  
  Chef::Log.info("Curr : #{flag} requested : #{@pkg_facet.facet_value}")
  if flag == @pkg_facet.facet_value
    return false
  else 
    
    if @pkg_facet.request_operation
      pkg_flags = pkg_flags + @pkg_facet.request_operation
    end
    
    if @pkg_facet.accept   
      pkg_flags = pkg_flags + " --accept"
    end
    
    if @pkg_facet.path_or_uri
      pkg_flags = pkg_flags + " -g #{@pkg_facet.path_or_uri}"
    end
    
    if @pkg_facet.no_be_activate
      pkg_flags =pkg_flags +" --no-be-activate"
    end
    
    if @pkg_facet.no_index
      pkg_flags =pkg_flags + " --no-index"
    end
    
    if @pkg_facet.no_refresh
      pkg_flags = pkg_flags + " --no-refresh"
    end
    
    if @pkg_facet.no_backup_be
      pkg_flags = pkg_flags + " --no-backup-be"
    end
    
    if @pkg_facet.require_backup_be
      pkg_flags =pkg_flags + " --require-backup-be"
    end
    
    if @pkg_facet.backup_name
      pkg_flags = ""
      flag = check_change_backup?
      
      if flag == true
        Chef::Log.info("The Value already Existing")
      else
        pkg_flags = pkg_flags + " --backup-be-name #{@pkg_facet.backup_name}" 
      end
    end
    
    
    if @pkg_facet.deny_new_be
      pkg_flags =pkg_flags + "--deny-new-be"
    end
    
    if @pkg_facet.require_new_be 
      pkg_flags =pkg_flags + " --require-new-be"
    end
    
    if @pkg_facet.be_name
      pkg_flags = pkg_flags + " --be-name #{@pkg_facet.bname}"
    end
    
    if @pkg_facet.sync_actuators
      timeout =""
      pkg_flags = pkg_flags + " --sync-actuators  #{@pkg_facet.timeout}"
    end
    
    if @pkg_facet.sync_actuators_timeout
      pkg_flags = "--sync-actuators-timeout  #{@pkg_facet.timeout}"
    end
    
    if @pkg_facet.reject
      pkg_flags = "--reject #{@pkg_facet.pkg_fmri_pattern}"
    end
    
    converge_by "Change the pkg change-facet  #{@pkg_facet.name}" do
      @change_facet = ("pkg change-facet  #{pkg_flags} #{@pkg_facet.name}=#{@pkg_facet.facet_value}")
      Chef::Log.info(@change_facet) 
      shell_out!(@change_facet, :timeout => 900)
      new_resource.updated_by_last_action(true)
    end
  end
end


private

def facet_status?
  @status = shell_out ("pkg facet -H #{@pkg_facet.name}")
  val = @status.stdout.split()
  Chef::Log.info("Current facet_value #{val[1]}")
  if val[1] == "False"
    return false
  else
    return true
  end
end

def check_change_backup?
  Chef::Log.info("Checking Pkg already created")
  @status = shell_out("beadm list -H #{@pkg_facet.backup_name}")
  flag = @status.exitstatus.zero?
  if @status.stdout.lines.count == 0
    flag = false
  end
  flag
end
