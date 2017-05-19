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
  @pkg_publisher = new_resource.class.new(new_resource.name)
  @pkg_publisher.type(new_resource.type)
  @pkg_publisher.uri(new_resource.uri)
  @pkg_publisher.root(new_resource.root)
  @pkg_publisher.sticky(new_resource.sticky)
  @pkg_publisher.non_sticky(new_resource.non_sticky)
  @pkg_publisher.search_before(new_resource.search_before)
  @pkg_publisher.search_after(new_resource.search_after)
  @pkg_publisher.ssl_cert(new_resource.ssl_cert)
  @pkg_publisher.ssl_key(new_resource.ssl_key)
  @pkg_publisher.enable(new_resource.enable)
  @pkg_publisher.disable(new_resource.disable)
  @pkg_publisher.publisher(new_resource.name)
  @pkg_publisher.proxy(new_resource.proxy)
  @pkg_publisher.syspub(new_resource.syspub)

  @pkg_publisher.list(list?)
  @pkg_publisher.current_props(current_props?)
  @pkg_publisher.info(info?)
end



action :create do
  unless created?
    puts "NO REPO FOUND"
    Chef::Log.info("Adding pkg #{@pkg_publisher.publisher} #{@pkg_publisher.uri} ")

    pkg_args = ""

    if (@pkg_publisher.type == "mirror")
      tmp = " -m #{@pkg_publisher.uri} " 
      pkg_args = pkg_args +  tmp
    else
      tmp = " -g #{@pkg_publisher.uri} "
      pkg_args = pkg_args + tmp
    end
   
    if (@pkg_publisher.sticky == true )
      tmp = " --sticky "
      pkg_args = pkg_args + tmp
    end
    
    if (@pkg_publisher.non_sticky == true)
      tmp = " --non-sticky "
      pkg_args = pkg_args + tmp
    end

    if (@pkg_publisher.search_before)
      tmp = " --search-before #{@pkg_publisher.search_before} "
      pkg_args = pkg_args + tmp
    end
    
    if (@pkg_publisher.search_after)
      tmp = " --search-after #{@pkg_publisher.search_after} "
      pkg_args = pkg_args + tmp
    end

    if (@pkg_publisher.ssl_cert)
      tmp = " -c #{@pkg_publisher.ssl_cert} "
      pkg_args = pkg_args + tmp
    end

    if (@pkg_publisher.ssl_key)
      tmp = " -k #{@pkg_publisher.ssl_key} "
      pkg_args = pkg_args + tmp
    end
         
    if (@pkg_publisher.enable == true)
      tmp = " --enable "
      pkg_args = pkg_args + tmp
    end

    if (@pkg_publisher.disable == true)
      tmp = " --disable "
      pkg_args = pkg_args + tmp
    end

    if (@pkg_publisher.proxy)
      tmp = " --proxy #{@pkg_publisher.proxy} "
      pkg_args = pkg_args + tmp
    end


	if (@pkg_publisher.root)
   		puts("pkg -R #{@pkg_publisher.root} set-publisher #{pkg_args} #{@pkg_publisher.publisher}")
    		shell_out!("pkg -R #{@pkg_publisher.root} set-publisher #{pkg_args} #{@pkg_publisher.publisher}")
	else
   		puts("pkg set-publisher #{pkg_args} #{@pkg_publisher.publisher}")
    		shell_out!("pkg set-publisher #{pkg_args} #{@pkg_publisher.publisher}")
	end

    new_resource.updated_by_last_action(true)
    @pkg_publisher.current_props(current_props?)
  end

end

action :destroy do
  if created?
    puts "Removing repository"
    Chef::Log.info("Destroy publisher  #{@pkg_publisher.publisher}")
    if @pkg_publisher.uri == ""
      puts ("pkg unset-publisher #{@pkg_publisher.publisher}")
      shell_out!("pkg unset-publisher #{@pkg_publisher.publisher}")
    else
      puts("pkg set-publisher -G #{@pkg_publisher.uri} #{@pkg_publisher.publisher}")
      shell_out!("pkg set-publisher -G #{@pkg_publisher.uri} #{@pkg_publisher.publisher}")
    end
    new_resource.updated_by_last_action(true)
  end
end

private

def created?
  Chef::Log.info("Checking pkg_publisher info")
  @pkg_publisher.info.zero?
end


def info?
  val = 1
  @list = @pkg_publisher.current_props
  @list.each { |x| 
  item = x
  puts x
            if item[:uri] == @pkg_publisher.uri  and item[:publisher] == @pkg_publisher.publisher
            if item[:type] == @pkg_publisher.type
                  #puts "FOUND"
                  val = 0
            end
          end
    }
  val         
end

def current_props?
  prop_hash = []
  item = {}
  index = 0
  @pkg_publisher.list.stdout.split("\n").each do |line|
    l = line.split(/\t/);
    item = {:publisher => l[0], :sticky => l[1], :syspub => l[2], 
      :enabled => l[3], :type => l[4], :status => l[5], :uri => l[6], :mirror => l[7]}
    prop_hash[index] = item
    index = index + 1
  end
  prop_hash
end

def list?
  Chef::Log.info("Current pkg pulisher")
  if (@pkg_publisher.root)
    shell_out("pkg -R #{@pkg_publisher.root} publisher -H -F tsv")
  else
    shell_out("pkg publisher -H -F tsv")
  end
end
