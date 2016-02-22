class Page < ActiveRecord::Base
  has_ancestry

  validates :name, presence: true, format: { with: /\A[\wа-яА-ЯёЁ]+\z/,
    message: 'contains invalid characters' }

  def to_param
    path = "#{ancestry}/" if ancestry
    "#{path}#{id}"
  end
end
