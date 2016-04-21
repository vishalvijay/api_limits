ActiveAdmin.register Repository do
  permit_params :name, :url, :description
end
