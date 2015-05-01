Pod::Spec.new do |s|
  s.name          = "RBStatefulTableViewContoller"
  s.version       = "0.0.1"
  s.summary       = "An UITableViewController that handles state transitions by using a custom DataSource and Delegate for each state."
  s.description   = <<-DESC
                    A basic state machine for UITableViewControllers that allow you to focus on each state independently of the others.
                    Build a DataSource/Delegate state object for each state your UITableView can be in and let the RBStatefulTableViewController
                    deal with switching between them.
                   DESC
  s.homepage      = "https://github.com/eoghain/RBStatefulTableViewContoller"
  s.license       = { :type => 'MIT' }
  s.author        = { "eoghain" => "rob.o.booth@gmail.com" }
  s.platform      = :ios
  s.source        = { :git => "https://github.com/eoghain/RBStatefulTableViewContoller.git", :tag => '0.0.1' }
  s.source_files  = "Classes", "Classes/**/*.{h,m}"
  s.exclude_files = "Classes/Exclude"
end
