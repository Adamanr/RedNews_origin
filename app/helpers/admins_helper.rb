module AdminsHelper
  def user_post_count(user)
    post_count = Event.where(user_id: user).count + Article.where(user_id: user).count
    return post_count
  end

end
