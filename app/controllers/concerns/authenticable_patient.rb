module AuthenticablePatient
  extend ActiveSupport::Concern

  private

    def current_patient
      @_current_patient ||= Patient.find_by(api_key: patient_api_key)
    end

    def patient_api_key
      @_patient_api_key ||= request.headers["Patient-Api-Key"].to_s.split.last
    end
end

