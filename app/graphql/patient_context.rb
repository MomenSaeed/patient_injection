module PatientContext
  def unauthorized
    execution_error(status: "Unauthorized", code: 401)
  end

  def logged_in?
    context[:current_patient].present?
  end

  def current_patient
    context[:current_patient]
  end

  def patient_api_key
    context[:patient_api_key]
  end

  private

    def execution_error(message: nil, errors: nil, status: :unprocessable_entity, code: 422)
      GraphQL::ExecutionError.new(
        message,
        options: {
          status:,
          code:,
          errors:,
        }
      )
    end
end

