object @resource
attributes :id, :name
node(:links) do
  {:rel => "self",
   :href => request.url,
   :type => "application/json"}
end
