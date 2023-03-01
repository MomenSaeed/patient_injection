class Injection < ApplicationRecord
  # == Validations ==========================================================
  validates :lot_number, presence: true, length: { is: 6 },
                    format: { with: /\A[A-Za-z0-9]+\z/, message: "only allows alphanumeric" }

  validates :dose, presence: true
  validates :drug_name, presence: true

  # == Relationships ========================================================
  belongs_to :patient
end

