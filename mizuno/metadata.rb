maintainer       "Dominique Broeglin"
maintainer_email "dominique.broeglin@gmail.com"
license          "Apache 2.0"
description      "Installs Mizuno"
long_description "Installs Mizuno" 
version          "1.0.0"

recipe "mizuno", "Installs mizuno"

%w{ gems }.each do |cb|
  depends cb
end

%w{ ubuntu debian centos rhel arch }.each do |os|
  supports os
end
