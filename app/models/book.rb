class Book < ApplicationRecord
  has_many :bookstore_books
  has_many :bookstore, through :bookstore_books
end
