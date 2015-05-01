Pod::Spec.new do |s|
  s.name          = "RBStatefulTableViewController"
  s.version       = "0.0.1"
  s.summary       = "An UITableViewController that handles state transitions by using a custom DataSource and Delegate for each state."
  s.homepage      = "https://github.com/eoghain/RBStatefulTableViewController"
  s.license       = 'MIT'
  s.author        = { "eoghain" => "rob.o.booth@gmail.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/eoghain/RBStatefulTableViewController.git", :tag => s.version }
  s.source_files  = "Classes", "Classes/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
  s.requires_arc  = true
end
