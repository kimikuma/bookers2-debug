class Book < ApplicationRecord

  #アソシエーション
  belongs_to:user
  has_many :favorites,dependent: :destroy
  has_many :book_comments,dependent: :destroy
  has_many :week_favorites,-> {where(created_at: 1.week.ago.beginning_of_day..Time.current.end_of_day)}

  #バリデーション
  validates :title,presence:true
  validates :body,presence:true,length:{maximum:200}

  #いいね機能を一回のみの使用にするための設定
  def favorited_by?(user)
    favorites.exists?(user_id:user.id)
  end

  #検索機能 条件分岐

  def self.looks(search,word)
    if search=="perfect_match"
      @book=Book.where("title LIKE?","#{word}")
    elsif search=="forward_match"
      @book=Book.where("title LIKE?","#{word}%")
    elsif search=="backward_match"
      @book=Book.where("title LIKE?","%#{word}")
    elsif search=="partial_match"
      @book=Book.where("title LIKE?","%#{word}%")
    else
      @book=Book.all
    end
  end


end
