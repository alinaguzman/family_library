class Author < ActiveRecord::Base
  has_many :author_books
  has_many :books, through: :author_books
  has_many :genres

  def name
    "#{first_name.capitalize} #{last_name.capitalize}"
  end
end
