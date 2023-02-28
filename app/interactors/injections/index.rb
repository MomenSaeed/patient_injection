class Injections::Index < BaseInteractor
  ERROR_MESSAGE = "injection.list_process_fails".freeze
  delegate :injections, to: :context

  def call
    context.injections = Injection.all
  end
end

