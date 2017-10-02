pkg_facet
=========

       Facets are treated as boolean values by package clients: Facets can be
       set  only to true (enabled) or false (disabled) in the image. By
       default, all facets starting with 'facet.debug.' or 'facet.optional.'
       are  considered to be set to false in the image; all others are consid-
       ered to be set to true in the image.

       Facets can be either set locally within an image using the pkg change-
       facet command or inherited from a parent image. For example, a non-
       global zone can inherit a facet from the global zone. Inherited facets
       are evaluated before, and take priority over, any locally set facets.
       If the same facet is both inherited and locally set, the inherited
       facet  value  masks the locally set value. Masked facets have no effect
       on facet evaluation and package actions. Facet changes made by using
       the pkg change-facet command only affect locally set facets. Inherited
       facets can only be changed by making the change in the parent image. By
       default, the pkg facet command does not display masked facets.

       The value of a facet tag on an action can be set to all or true to con-
       trol how clients filter faceted actions. All values other than all or
       true have undefined behavior. See below for a description of the condi-
       tions that must exist in the image to install an action that has facet
       tags.


Requirements
============

     * Chef Client 12.16.42
     * Oracle Solaris 11.3 SRU19


Attributes
==========

pkg_facet Cookbook attributes.

<table border="1" bgcolor="#8080cc">
 <tr>
    <th>Key</th>
    <th>Type</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
<tr>
    <td><tt>name</tt></td>
    <td>String</td>
    <td>name</td>
    <td><tt></tt></td>
  </tr>
<td><tt>facet_value</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>

<td><tt>mediation</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>

<td><tt>request_operation</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>RequestOperation</tt></td>
  </tr>

<td><tt>accept</tt></td>
    <td>Boolean</td>
    <td></td>
    <td><tt>false</tt></td>
  </tr>

<td><tt>operation</tt></td>
    <td>String</td>
    <td></td>
    <td><tt>operation</tt></td>
  </tr>

 <tr>
    <td><tt>version</tt></td>
    <td>String</td>
    <td>version</td>
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>path_or_uri</tt></td>
    <td>String</td>
    <td></td> 
    <td><tt></tt></td>
  </tr>
   <tr>
    <td><tt>no_index</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
   <tr>
    <td><tt>no_refresh</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr> 

 <td><tt>require_backup_be</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr> 

  <tr>
    <td><tt>request_operation</tt></td>
    <td>String</td>
    <td>request_operation</td> 
    <td><tt></tt></td>
  </tr>
  <tr>
    <td><tt>sync_actuators</tt></td>
    <td>Boolean</td>
    <td>sync_actuators</td> 
    <td>false</td>
  </tr>
  <tr>
    <td><tt>timeout</tt></td>
    <td>Integer</td>
    <td>Time</td> 
    <td><tt></tt></td>
  </tr>

  <tr>
    <td><tt>sync_actuators_timeout</tt></td>
    <td>Integer</td>
    <td>Time</td> 
    <td><tt></tt></td>
  </tr>

<tr>
    <td><tt>path_uri</tt></td>
    <td>Boolean</td>
    <td></td> 
    <td><tt>false</tt></td>
  </tr>
</table>
  

Usage
=====
  
Showing and Changing Facet Values
---------------------------------
```ruby
 
pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value false
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_backup_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  accept  "accept"
   action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_be_activate true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_refresh true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_backup_be true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  require_backup_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  be_name true 
  bname  "gust1"
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  no_index true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  no_refresh true
  action :change_facet
end


pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
   require_new_be true
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  sync_actuators_timeout true
  timeout 10
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value false
  backup_name "oracle" 
  action :change_facet
end

pkg_facet "facet.version-lock.system/library/gcc/gcc-c-runtime" do
  facet_value true
  path_or_uri "http://ipkg.uk.oracle.com/solaris11/support/" 
  action :change_facet
end
end
```

Contributing
------------
Process for contributing.

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write your change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github

 License and Authors
 -------------------
```text

Author:: Pradhap Devarajan ([pradhap.devarajan@oracle.com](mailto:pradhap.devarajan@oracle.com))


Copyright:: 2017 Oracle and/or its affiliates. All rights reserved.

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
```
