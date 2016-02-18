class Page < ActiveRecord::Base
  validates :name, presence: true, format: { with: /\A[\wа-яА-ЯёЁ]+\z/,
    message: 'contains invalid characters' }
end
