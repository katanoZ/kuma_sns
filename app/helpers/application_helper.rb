module ApplicationHelper
  def profile_img(user, size: :default)
    if user.avatar.present?
      case size
      when :small
        return image_tag(user.avatar, alt: user.name, size: "50x50", class: "img-rounded")
      when :medium
        return image_tag(user.avatar, alt: user.name, size: "180x180", class: "img-rounded")
      else
        return image_tag(user.avatar, alt: user.name, class: "max100 img-rounded")
      end
    end

    if user.provider.present?
      case size
      when :small
        return image_tag(user.image_url, alt: user.name, size: "50x50", class: "img-rounded")
      when :medium
        return image_tag(user.image_url, alt: user.name, size: "180x180", class: "img-rounded")
      else
        return image_tag(user.image_url, alt: user.name, class: "max100 img-rounded")
      end
    end

    case size
    when :small
      image_tag("no_image.png", alt: user.name, size: "50x50", class: "img-rounded")
    when :medium
      image_tag("no_image.png", alt: user.name, size: "180x180", class: "img-rounded")
    else
      image_tag("no_image.png", alt: user.name, class: "max100 img-rounded")
    end
  end
end
