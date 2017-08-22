## Copyright (c) 2017, Oracle and/or its affiliates. All rights reserved.
##
## Licensed under the Apache License, Version 2.0 (the "License");
## you may not use this file except in compliance with the License.
## You may obtain a copy of the License at
##
##     http://www.apache.org/licenses/LICENSE-2.0
##
## Unless required by applicable law or agreed to in writing, software
## distributed under the License is distributed on an "AS IS" BASIS,
## WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
## See the License for the specific language governing permissions and
## limitations under the License.

include Chef::Mixin::ShellOut

use_inline_resources

def whyrun_supported?
  true
end

def load_current_resource
  @svccfg= Chef::Resource.resource_for_node(new_resource.declared_type, run_context.node).new(new_resource.name)
  @svccfg.fmri(new_resource.fmri)
  @svccfg.instance(new_resource.instance)
  @svccfg.site_profile(new_resource.site_profile)
  @svccfg.layers(new_resource.layers)
  @svccfg.value(new_resource.value)
  @svccfg.delete_service(new_resource.delete_service)
  @svccfg.property_group(new_resource.property_group)
  @svccfg.property(new_resource.property)
  @svccfg.type(new_resource.type)
  @svccfg.value(new_resource.value)
  @svccfg.layout(new_resource.layout)
  @svccfg.new_value(new_resource.new_value)
  @svccfg.globpattern(new_resource.globpattern)
  @svccfg.pg_name(new_resource.pg_name)
  @svccfg.environment(new_resource.environment)
  @svccfg.method_name(new_resource.method_name)
  @svccfg.file_name(new_resource.file_name)
  @svccfg.options(new_resource.options)
  @svccfg.application(new_resource.application)
  @svccfg.type(new_resource.type)
end



action :import do
  converge_by "svccfg import  #{@svccfg.file_name}" do
    @import=("svccfg import #{@svccfg.file_name}")
    Chef::Log.info(@import)
    shell_out!(@import)
  end 
end


action :export do
  converge_by "svccfg export  " do
    @export=("svccfg export #{@svccfg.fmri} > #{@svccfg.file_name}")
    Chef::Log.info(@export)
    shell_out!(@export)
  end 
end


action :inventory do
  converge_by "svccfg  determined service manifest " do
    @inventory=("svccfg inventory #{@svccfg.dump_name}>#{@svccfg.name}")
    Chef::Log.info(@inventory)
    shell_out!(@inventory)
  end
end


action :validate do
  converge_by "svccfg validate  #{@svccfg.name}" do
    @validate=("svccfg validate #{@svccfg.name}")
    Chef::Log.info(@validate)
    shell_out!(@validate)
  end
end


action :delete do
  Chef::Log.info ("svccfg instance already exists #{@svccfg.name}")
  flag =instance_exists?
  if flag ==0
    converge_by "svccfg for deleting the instance " do
    @delete=("svccfg delete #{@svccfg.name}")
    Chef::Log.info(@delete)
    shell_out!(@delete)
  end
else
  Chef::Log.info ("svccfg Instance not available #{@svccfg.name}")
end
end


action :extract do   
  
  svccfg_flags =""
  
  if @svccfg.layers
    svccfg_flags = svccfg_flags + '-l'
  end
  
  converge_by "Service profile for the specified service" do
  @extract=("svccfg extract #{svccfg_flags} current  #{@svccfg.instance} > #{@svccfg.site_profile}")
  Chef::Log.info(@extract)
  shell_out!(@extract)
  end
end


action :refresh do
  converge_by "svccfg  describe number of values allowed in the set of values. " do
    @refresh=("svccfg refresh #{@svccfg.name} ")
    Chef::Log.info(@refresh)
    shell_out!(@refresh)
  end
end


action :revert do
  converge_by "svccfg  describe number of values allowed in the set of values. " do
    @revert=("svccfg -s #{@svccfg.name} revert previous")
    Chef::Log.info(@revert)
    shell_out!(@revert)
  end
end


action :setprop do
  converge_by "svccfg  Changes the value of a property" do
    options = {}
    flag = setpro_exists(@svccfg.property,@svccfg.type)
    if flag == true
      @setprop=("svccfg -s #{@svccfg.name} setprop  #{@svccfg.property}=#{@svccfg.value}")
      Chef::Log.info(@setprop)
      shell_out!(@setprop)
    else
      Chef::Log.info("Syntax error type mismatch")
      return false
    end 
  end
end


action :delprop do
  converge_by "svccfg  Delete the property" do
    options = {}
    @svccfg.options.each do |key, val|
      @key =key
      flag = delpro_exists(@key)
      if flag == false
        @delprop=("svccfg -s #{@svccfg.name} delprop  #{@key}")
        Chef::Log.info(@delprop)
        shell_out!(@delprop)
      else
        Chef::Log.info("The property value is not exists ")
        return true
      end 
    end
  end
end


action :addpg do
  converge_by "svccfg Adding Property Groups" do
    options = {}
    @svccfg.options.each do |key, val|
      @key =key
      @val =val
      flag = addpg(@key)
      if flag == true
        @addpg=("svccfg -s #{@svccfg.name} addpg #{@key} #{@val}")
        Chef::Log.info(@addpg)
        shell_out!(@addpg)
      else
        return false
      end 
    end
  end
end


action :delpg do
  converge_by "svccfg  Delete the property" do
    options = {}
    @svccfg.options.each do |key, val|
      @key =key
      flag = delpg_exists(@key)
      if flag == false
        @delpg=("svccfg -s #{@svccfg.name} delpg  #{@key}")
        Chef::Log.info(@delpg)
        shell_out!(@delpg)
      else
        Chef::Log.info("The property value is not exists ")
        return true
      end 
    end
  end
end


action :addpropvalue do
  converge_by "svccfg Adding Property values" do
    options = {}
    @svccfg.options.each do |key, val|
      @key =key
      @val =val
      flag = addpg(@key)
      if flag == true
        @addprop=("svccfg -s #{@svccfg.name} addpropvalue #{@key} #{@svccfg.type}: #{@val}")
        Chef::Log.info(@addprop)
        shell_out!(@addprop)
      else
        return false
      end 
    end
  end
end


action :delpropvalue do
  converge_by "svccfg  Delete the property" do
    options = {}
    @svccfg.options.each do |key, val|
      @key =key
      flag = delpro_exists(@key)
      if flag == false
        @delprop=("svccfg -s #{@svccfg.name} delprop  #{@key}")
        Chef::Log.info(@delprop)
        shell_out!(@delprop)
      else
        Chef::Log.info("The property value is not exists ")
        return true
      end 
    end
  end
end


private

def instance_exists?
  Chef::Log.info("Check if Instance already existing")
  cmd_out = shell_out("svcs -a #{@svccfg.name}")
  cmd_out.exitstatus
end


def setpro_exists(property,type)
  Chef::Log.info("Checking Setpro already available")
  @status = shell_out("svccfg -s system-log listprop  #{@svccfg.property}")
  flag = @status.exitstatus
  val= @status.stdout.split(' ')
  Chef::Log.info("Curr : #{@svccfg.property} Check: #{val[0]}")
  Chef::Log.info("Curr : #{@svccfg.type} Check: #{val[1]}")
  if val[1] == @svccfg.type && val[0] == @svccfg.property 
    return true
  else
    return false
  end
end


def delpro_exists(value)
  Chef::Log.info("Checking property is not exists")
  @status = shell_out("svccfg -s system-log listprop  #{@key}")
  flag = @status.exitstatus.zero?
  val= @status.stdout.split(' ')
  Chef::Log.info("Curr : #{val[0]} Check: #{value}")
  if val[0].to_s == value.to_s
    return false
  else
    return true
  end 
end


def delpg_exists(value)
  Chef::Log.info("Checking property is not exists")
  @status = shell_out("svccfg -s system-log listprop  #{@key}")
  flag = @status.exitstatus.zero?
  val= @status.stdout.split(' ')
  Chef::Log.info("Curr : #{val[0]} Check: #{value}")
  if val[0].to_s == value.to_s
    return false
  else
    return true
  end 
end


def addpg(value)
  Chef::Log.info("Checking property already available")
  @status = shell_out("svccfg -s system-log listprop  #{@key}")
  flag = @status.exitstatus.zero?
  val= @status.stdout.split(' ')
  Chef::Log.info("Curr : #{val[0]} Check: #{value}")
  if val[0].to_s == value.to_s
    return false
  else
    return true
  end 
end
