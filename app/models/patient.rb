class Patient < ApplicationRecord
  # == Validations ==========================================================
  validates :api_key, presence: true, uniqueness: true

  validates :full_name, presence: true

  # == Relationships ========================================================
  has_many  :injections
end

