class BaseInteractor
  include Interactor

  ERROR_MESSAGE = "process.failed".freeze

  private

    def group_errors(record)
      context.errors = record.errors
      raise_failure
    end

    def raise_failure
      context.fail!(message: ERROR_MESSAGE)
    end
end

