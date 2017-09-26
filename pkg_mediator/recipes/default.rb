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


pkg_mediator "java" do
  version "1.8"
  action :mediator
end


pkg_mediator "java" do
  version "1.10"
  no_be_activate true
  action :mediator
end

pkg_mediator "xxx" do
  version "1.15"
  no_backup_be true
  action :mediator
end


pkg_mediator "java" do
    version "1.9"
  deny_new_be true
  action :mediator
end


pkg_mediator "java" do
  version "1.8"
  require_new_be true
  action :mediator
end


pkg_mediator "java" do
  version "1.8"
  be_name true
  bname "testing"
  action :mediator
end




