class ArticleLikesController < ApplicationController
  def create
    article = Article.find(params[:id])
    article_like = article.article_likes.build(user_id: current_user)
    if article_like.save
      # Лайк успешно добавлен
      redirect_to article_path(article), notice: 'Article liked!'
    else
      # Обработка ошибки
      redirect_to article_path(article), alert: 'Error liking article'
    end
  end

  def destroy
    article_like = current_user.article_likes.find_by(article_id: params[:id])
    if article_like.destroy
      # Лайк успешно удален
      redirect_to article_path(article_like.article), notice: 'Article unliked!'
    else
      # Обработка ошибки
      redirect_to article_path(article_like.article), alert: 'Error unliking article'
    end
  end
end
