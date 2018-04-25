class Note < ApplicationRecord
  belongs_to :user
  has_many :has_collections,dependent: :delete_all
  has_many :collections, through: :has_collections
  validates :title, presence: true 
  validates :body, presence: true

  #has_attached_file :photo, styles: {ancho: "500x300", largo: "300x500"}
  #validates_attachment_content_type :photo, content_type: /\Aimage\/.*\Z/

  FOTOS = File.join Rails.root, 'public', 'photo_store'
  after_save :guardar_foto

  def photo=(file_data)
  	unless file_data.blank?
  		@file_data = file_data
  		self.extension = file_data.original_filename.split('.').last.downcase
  	end
  end

  def photo_filename
  	File.join FOTOS, "#{id}.#{extension}"
  end

  def photo_path
  	"/photo_store/#{id}.#{extension}"
  end

  def has_photo?
  	File.exists? photo_filename
  end
  private
  	def guardar_foto
  		if @file_data
  			FileUtils.mkdir_p FOTOS
  			File.open(photo_filename, "wb") do |f|
  				f.write(@file_data.read)
  			end
  			@file_data = nil
  		end
  	end

end
