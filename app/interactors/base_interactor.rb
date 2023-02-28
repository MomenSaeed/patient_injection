class BaseInteractor
  include Interactor

  ERROR_MESSAGE = "process.failed".freeze

  private

    def group_errors(record)
      record.errors.group_by_attribute.each_key do |attr|
        context.errors.push("#{attr}.not_valid")
      end
      raise_failure
    end

    def raise_failure
      context.fail!(message: ERROR_MESSAGE)
    end
end

