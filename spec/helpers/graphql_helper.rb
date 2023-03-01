module GraphqLHelper
  def graphql_query(query:, variables: {}, api_key: nil)
    auth_header = { "Patient-Api-Key": api_key } if api_key.present?
    post "/graphql", params: { query:, variables: }, headers: auth_header
  end

  def graphql_data(*args)
    JSON.parse(response.body).dig(*args)
  end

  def hash_to_mutation(attributes)
    attr_gql_str = attributes.map { |k, v| "#{k}: #{v.inspect}" }.join(", ")
    " { #{attr_gql_str} } "
  end
end

