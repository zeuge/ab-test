class Page < ActiveRecord::Base
  has_ancestry

  validates :id, presence: true, uniqueness: true, format: { with: /\A[\wа-яА-ЯёЁ]+\z/,
    message: 'contains invalid characters' }

  def to_param
    path = "#{ancestry}/" if ancestry
    "#{path}#{id}"
  end
end
