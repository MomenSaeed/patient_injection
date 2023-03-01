class Injections::Create < BaseInteractor
  ERROR_MESSAGE = "injection.create_failed".freeze

  delegate :injection, to: :context
  delegate :patient, to: :context

  before :set_injection, :validate_injection

  def call
    injection.save
  end

  private

    def set_injection
      context.injection = Injection.new(context.injection_params).tap do |i|
        i.patient = patient
      end
    end

    def validate_injection
      context.errors = []
      return if injection.valid?

      group_errors(injection)
    end
end

