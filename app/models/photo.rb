class Photo < ActiveRecord::Base
  has_attached_file :pic, :styles => { :large => '1200x900>', :small => '400x300>', :thumb => '80x60#' }

  belongs_to :photo_data, :polymorphic => true
end
