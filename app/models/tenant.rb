class Tenant < ApplicationRecord
    has_many :leases, dependent: :destroy
    has_many :apartments, through: :leases

    validates :name, presence: true
    validate :age_greater_than_or_equal_to_eighteen

    def age_greater_than_or_equal_to_eighteen
        unless age >= 18
            errors.add(:age, "Age must be greater than or equal to 18")
        end
    end
end
