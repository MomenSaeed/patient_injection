class Mutations::CreateInjection < Mutations::BaseMutation
  field :injection, Types::Injection::Type, null: false
  argument :injection, Types::Injection::Input, required: false

  def resolve(injection:)
    create_injection = Injections::Create.call(injection_params: injection.to_h)
    create_injection.success? ? { injection: create_injection.injection } : execution_error(errors: create_injection.errors)
  end
end

