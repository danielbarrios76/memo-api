class Memo < ApplicationRecord
  validates :title, presence: true
  validates :body, presence: true


  def comply
    update_atributes(complied: true)
  end
end
