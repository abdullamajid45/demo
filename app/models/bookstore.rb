class Bookstore < ApplicationRecord
  has_many :bookstore_books
  has_many :books, through :bookstore_books
end
