#micropost model
class Micropost < ActiveRecord::Base
   belongs_to :user
   default_scope -> { order(created_at: :desc) }
   mount_uploader :picture, PictureUploader
   validates :user_id, presence: true
   validates :content, presence: true, length: { maximum: 140 }
   validate  :picture_size
   has_many :active_relationlikes,  class_name: "Relationlike",
                                    foreign_key: "post_id",
                                    dependent: :destroy
   has_many :likings, through: :active_relationlikes, source: :liker

	#like
	def like(o_user)
		active_relationlikes.create(liker_id: o_user.id)
	end

	#no like
	def unlike(o_user)
		active_relationlikes.find_by(liker_id: o_user.id).destroy
	end

	#like to user
	def likings?(o_user)
		likings.include?(o_user)
	end
    

private
    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end
end