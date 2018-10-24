class Memo < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true

  def comply!
    update_attributes(complied: true)
  end
end
