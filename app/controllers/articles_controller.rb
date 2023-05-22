class ArticlesController < ApplicationController
  before_action :set_article, only: %i[show edit update destroy]

  # GET /articles or /articles.json
  def index
    if params[:search].present?
      @articles = Article.joins(:user).where("users.name ILIKE ?", "%#{params[:search]}%")
    else
      @articles = Article.all
    end

    @popular_tags = Article.tag_counts(limit: 4)


    respond_to do |format|
      format.html
      format.json { render json: { results: render_to_string(partial: "articles/list", locals: { articles: @articles }) } }
    end
  end

  def bookmark
    @article = Article.find(params[:id])
    current_user.articles << @article
    redirect_to @article, notice: "Статья добавлена в закладки"
  end

  def unbookmark
    @article = Article.find(params[:id])
    current_user.articles.delete(@article)
    redirect_to @article, notice: "Статья удалена из закладок"
  end

  def like
    @article = Article.find(params[:id])
    @article_like = current_user.article_likes.find_by(user_id: @article.id)
    respond_to do |format|
      format.html { redirect_to @article }
      format.json { render json: { likes_count: @article.article_likes.count } }
    end
  end
  # GET /articles/1 or /articles/1.json
  def show
    @user = User.find(@article.user_id)
    impressionist(@article)
    @article_like = current_user.article_likes.find_by(article_id: @article.id) if user_signed_in?
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  def find
  end

  def selected
  end

  def tag
    tag_name = params[:tag]
    @articles = Article.tagged_with(tag_name)
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = Article.new(article_params)
    @article.user_id = current_user.id
    @article.tag_list = params[:article][:tag_list] # Получаем теги из параметров формы

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    @article.tag_list = params[:article][:tag_list] # Получаем теги из параметров формы

    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy

    respond_to do |format|
      format.html { redirect_to articles_url, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def create_comment
    @article = Article.find(params[:id])
    @comment = @article.articles_comments.build(comment_params)
    @comment.user = current_user

    if @comment.save
      redirect_to @article, notice: 'Comment created successfully.'
    else
      redirect_to @article, alert: 'Failed to create comment.'
    end
  end

  private
    def comment_params
      params.require(:articles_comment).permit(:content)
    end

    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :header, :tags)
    end
end
