class User < ApplicationRecord
  before_save { self.name.downcase! }
  validates :name, presence: true, length: { maximum: 30 },
                    uniqueness: { case_sensitive: false }
  has_secure_password
end
