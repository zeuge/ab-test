class Page < ActiveRecord::Base
  before_validation :sanitize_html, on: [:create, :update]

  has_ancestry

  validates :id, presence: true, uniqueness: true, format: { with: /\A[\wа-яА-ЯёЁ]+\z/,
    message: 'contains invalid characters' }

  def to_param
    path = "#{ancestry}/" if ancestry
    "#{path}#{id}"
  end

  private

  def sanitize_html
    return nil unless self.body
    body = self.body.
      # **[строка]** => <b>[строка]</b> (выделение жирным)
      gsub(/\*{2}(.+?)\*{2}/, '<b>\1</b>').
      # \\[строка]\\ => <i>[строка]</i> (выделение курсивом)
      gsub(/\\{2}(.+?)\\{2}/, '<i>\1</i>').
      # ((name1/name2/name3 [строка])) => <a href="[site]name1/name2/name3">[строка]</a>
      gsub(/\({2}([\wа-яА-ЯёЁ]+(\/[\wа-яА-ЯёЁ]+)*) (.+?)\){2}/, '<a href="\1">\3</a>')

      # [\wа-яА-ЯёЁ]+(\/[\wа-яА-ЯёЁ]+)*

    self.html = ActionController::Base.helpers.sanitize body
  end
end
