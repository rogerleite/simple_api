object false #uses no record

node(:total_resultado) { 100 }
node(:paginas_totais) { 1 }
node(:itens_por_pagina) { 10 }
node(:paginal_atual) { 1 }
node(:query) { "" }
node(:links) do
  {:rel => "self",
   :href => request.url,
   :type => "application/json"
  }
end
node(:resultado) do
  @resources.map do |resource|
    {:id => resource.id,
     :name => resource.name,
     :links => [{:rel => "recurso",
                 :href => "http://localhost:9292/recursos/id/#{resource.id}",
                 :type => "application/json"
                }]
    }
  end
end

#collection(@edicoes) do |collection, edicoes|
#
#  collection.values do |value|
#    value.total_resultado     @edicoes.total_count.to_i
#    value.paginas_totais      @edicoes.num_pages.to_i
#    value.itens_por_pagina    @edicoes.limit_value.to_i
#    value.pagina_atual        edicoes.current_page
#    value.query               params.except(:controller, :action, :format, :page).to_query
#  end
#
#  collection.link 'self',     request.url
#  collection.link 'search',   search_domain_api_edicoes_url, "type" => "application/opensearchdescription+xml"
#
#  if @edicoes.current_page > 1
#    collection.link 'primeira', request_url(search_domain_api_edicoes_url, 1, params)
#    collection.link 'anterior', request_url(search_domain_api_edicoes_url, @edicoes.current_page - 1, params)
#  elsif @edicoes.current_page < @edicoes.num_pages
#    collection.link 'ultima',   request_url(search_domain_api_edicoes_url, @edicoes.num_pages.to_i, params)
#    collection.link 'proxima',  request_url(search_domain_api_edicoes_url, @edicoes.current_page + 1, params)
#  end
#
#  collection.members(:root => 'resultado') do |member, edicao|
#    member.values do |m|
#      m.id           domain_api_edicao_url(edicao.cod_edicao)
#      m.cod_edicao   edicao.cod_edicao
#      m.data_edicao  edicao.data_edicao_formatada
#      m.tipo_recurso Domain::Edicao::TIPO_RECURSO
#    end
#    member.link(Domain::Edicao::TIPO_RECURSO, domain_api_edicao_url(edicao.cod_edicao))
#  end
#end

