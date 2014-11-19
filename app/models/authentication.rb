class Authentication < ActiveRecord::Base
  belongs_to :user
  attr_accessible :provider, :uid

  def create_user(auth_info)
    name, image, email = auth_info['name'], auth_info['image'], auth_info['email']
    user = User.new(name: name, remote_photo_url: image)
    if email
      user.email = email
      user.confirmed_at = Time.now
    end
    user.authentications = [ self ]
    user.save!
    user
  end
end
