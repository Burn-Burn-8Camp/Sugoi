# app/models/image.rb
class Image < ApplicationRecord   
# CarrierWave 的寫法
# mount_uploader :file, ImageUploader
    
 # Active Storage 的寫法
has_one_attached :file
    
end