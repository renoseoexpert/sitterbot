# == Schema Information
#
# Table name: events
#
#  id            :integer          not null, primary key
#  food_included :boolean          default(FALSE)
#  starts_at     :datetime         not null
#  ends_at       :datetime         not null
#  key           :string           not null
#  sitter_id     :integer          not null
#  parent_id     :integer          not null
#  flat_rate     :integer
#  created_at    :datetime         not null
#  updated_at    :datetime         not null
#
# Indexes
#
#  index_events_on_parent_id  (parent_id)
#  index_events_on_sitter_id  (sitter_id)
#

class Event < ActiveRecord::Base
  validates :parent, :sitter, presence: true
  belongs_to :sitter
  belongs_to :parent

  before_validation(on: :create) do
    self.key ||= SecureRandom.hex
  end
end
