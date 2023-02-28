class Injections::Details < BaseInteractor
  ERROR_MESSAGE = "injection.not_exists".freeze

  delegate :injection, to: :context

  def call
    context.injection = Injection.find_by_id(context.injection_id)
  end
end

