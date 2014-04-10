class User < ActiveRecord::Base
	before_save { self.email = email.downcase }
	before_create :create_remember_token

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
	validates :name, presence: true, length: { maximum: 50, minimum: 2 }
	validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },uniqueness: { case_sensitive: false }
	validates :password, length: { minimum: 6 }
	has_secure_password

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
  has_many :file_records, dependent: :destroy
  has_many :viewer_logs, dependent: :destroy

	def User.new_remember_token
		SecureRandom.urlsafe_base64
	end

	def User.encrypt(token)
		Digest::SHA1.hexdigest(token.to_s)
	end

  def is_admin?
    self.admin
  end

  def portrait_url(size='s')
    portrait_path = if Rails.env == 'development'
                      if File.exist? "#{Rails.root}/app/assets/images/portraits/#{self.id}.png"
                        "/assets/portraits/#{self.id}.png"
                      else
                        "/assets/portraits/default_portrait.png"
                      end
                    elsif Rails.env == 'production'
                      if File.exist? "/home/nagae-memooff/rails/blog_nagamemo/shared/portraits/#{self.id}.png"
                        "/portraits/#{self.id}.png"
                      else
                        "default_portrait.png"
                      end
                    end
    portrait_path
  end

	private

	def create_remember_token
		self.remember_token = User.encrypt(User.new_remember_token)
	end
end
