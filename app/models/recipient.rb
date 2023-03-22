class Recipient < ApplicationRecord
  has_many :recipient_allergens, dependent: :destroy
  has_many :allergens, through: :recipient_allergens

  has_many :recipient_shipments, dependent: :destroy
  has_many :shipments, through: :recipient_shipments

  def self.to_csv
    recipients = all
    CSV.generate do |csv|
      csv << %w[email notes allergies].freeze
      recipients.each do |r|
        csv << [r.email, r.notes, r.allergens.map(&:title).join('|')]
      end
    end
  end
end
