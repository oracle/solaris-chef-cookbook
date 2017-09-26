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
  @pkg_mediator = Chef::Resource.resource_for_node(new_resource.declared_type, run_context.node).new(new_resource.name)
  @pkg_mediator.name(new_resource.name)
  @pkg_mediator.version(new_resource.version)
  @pkg_mediator.no_be_activate(new_resource.no_be_activate)
  @pkg_mediator.no_backup_be(new_resource.no_backup_be)
  @pkg_mediator.deny_new_be(new_resource.deny_new_be)
  @pkg_mediator.require_new_be(new_resource.require_new_be)
  @pkg_mediator.be_name(new_resource.be_name)
  @pkg_mediator.bname(new_resource.bname)
end


action :mediator do
  pkg_flags = ""
  
  flag = facet_status(@pkg_mediator.name, @pkg_mediator.version)
  
  Chef::Log.info("Curr : #{flag} requested : #{@pkg_mediator.name}")
  
  if flag ==false
    Chef::Log.info("pkg_mediator type mismatch #{@pkg_mediator.name}")
  else
    
    if @pkg_mediator.version
      pkg_flags = pkg_flags + "-V " + @pkg_mediator.version
    end
    
    if @pkg_mediator.no_be_activate
      pkg_flags = pkg_flags + " --no-be-activate"
    end
    
    if @pkg_mediator.no_backup_be
      pkg_flags = pkg_flags + " --no-backup-be"
    end
    
    if @pkg_mediator.deny_new_be
      pkg_flags = pkg_flags + " --deny-new-be"
    end
    
    if @pkg_mediator.require_new_be 
      pkg_flags =pkg_flags +  " --require-new-be"
    end
    
    if @pkg_mediator.bname
      pkg_flags = pkg_flags + " --be-name #{@pkg_mediator.bname}"
    end
    
    converge_by "Change the pkg set-mediator #{@pkg_mediator.name}" do
      @pkg_mediator = ("pkg set-mediator #{pkg_flags} #{@pkg_mediator.name}")
      Chef::Log.info(@pkg_mediator) 
      shell_out!(@pkg_mediator)
      new_resource.updated_by_last_action(true)
    end
  end
end


private

def facet_status(name,version)
  cmd_out = shell_out ("pkg mediator -H #{@pkg_mediator.name}")
  val = cmd_out.stdout.split()
  if val[0] == @pkg_mediator.name && val[2] == @pkg_mediator.version
    return false
  else
    return true
  end
end

