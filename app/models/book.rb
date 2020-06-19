# frozen_string_literal: true

class Book < ApplicationRecord
  belongs_to :user
  has_many :favorites, dependent: :destroy
  has_many :book_comments, dependent: :destroy

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  def Book.create_test
    Book.create(title: 'test', body: 'testtest', user_id: '1')
  end

  # バリデーションは該当するモデルに設定する。エラーにする条件を設定できる。
  validates :title, presence: true
  validates :body, presence: true, length: { maximum: 200 }
end
