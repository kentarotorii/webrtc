module ApplicationHelper
  def profile_img(user)
    return image_tag(user.avatar, alt: user.name) if user.avatar?

    img_url = 'no_image.png'
    image_tag(img_url, alt: user.name)
  end
end
