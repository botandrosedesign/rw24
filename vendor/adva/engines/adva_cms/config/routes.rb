ActionController::Routing::Routes.draw do |map|
  scope :constraints => lambda { |req| Page.where(:permalink => req.params[:section_permalink]).exists? } do
    get "/:section_permalink" => "articles#index", :as => :section
    get "/:section_permalink/articles/:permalink" => "articles#show", :as => :article
  end

  map.connect 'admin',            :controller   => 'admin/sites',
                                  :action       => 'index',
                                  :conditions => { :method => :get }

  map.resources :sites,           :controller   => 'admin/sites',
                                  :path_prefix  => 'admin',
                                  :name_prefix  => 'admin_'

  map.resources :sections,        :controller  => 'admin/sections',
                                  :path_prefix => 'admin/sites/:site_id',
                                  :name_prefix => 'admin_'

  map.connect                     'admin/sites/:site_id/sections',
                                  :controller   => 'admin/sections',
                                  :action       => 'update_all',
                                  :conditions   => { :method => :put }

  map.resources :contents,        :path_prefix => "admin/sites/:site_id/sections/:section_id",
                                  :name_prefix => "admin_",
                                  :namespace   => "admin/"

  map.connect                     'admin/sites/:site_id/sections/:section_id/contents',
                                  :controller   => 'admin/contents',
                                  :action       => 'update_all',
                                  :conditions   => { :method => :put }

  map.resources :articles,        :path_prefix => "admin/sites/:site_id/sections/:section_id",
                                  :name_prefix => "admin_",
                                  :namespace   => "admin/"

  map.connect                     'admin/sites/:site_id/sections/:section_id/articles',
                                  :controller   => 'admin/articles',
                                  :action       => 'update_all',
                                  :conditions   => { :method => :put }

  map.resources :links,           :path_prefix => "admin/sites/:site_id/sections/:section_id",
                                  :name_prefix => "admin_",
                                  :namespace   => "admin/"

  map.connect                     'admin/sites/:site_id/sections/:section_id/links',
                                  :controller   => 'admin/links',
                                  :action       => 'update_all',
                                  :conditions   => { :method => :put }

  map.resources :categories,      :path_prefix => "admin/sites/:site_id/sections/:section_id",
                                  :name_prefix => "admin_",
                                  :namespace   => "admin/"

  map.connect                     'admin/sites/:site_id/sections/:section_id/categories',
                                  :controller   => 'admin/categories',
                                  :action       => 'update_all',
                                  :conditions   => { :method => :put }

  map.connect                     'admin/cells.xml', :controller => 'admin/cells', :action => 'index', :format => 'xml'
end
