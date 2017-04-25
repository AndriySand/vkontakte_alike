class ArticlesController < ApplicationController
  before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!, only: [:new, :edit, :update, :destroy]

  # GET /articles
  # GET /articles.json
  def index
    @articles = Article.paginate(page: params[:page], per_page: 30)
  end

  # GET /articles/1
  # GET /articles/1.json
  def show
    @attachable_comments = Comment.order(created_at: :desc).where("article_id <> #{@article.id}").paginate(page: params[:page_attach_comm], per_page: 5)
    if params[:page_attach_comm]
      render partial: 'shared/append_items', locals:
        { appendable_body: '.attachable-comments tbody', partial: 'shared/attachable_item', collection: @attachable_comments,
          item: :item, scrollable_div: '#attachable-comments-pagination .pagination', param_name: 'page_attach_comm' } and return
    end
    @attachable_articles = Article.order(created_at: :desc).paginate(page: params[:page_attach_art], per_page: 5)
    if params[:page_attach_art]
      render partial: 'shared/append_items', locals:
        { appendable_body: '.attachable-articles tbody', partial: 'shared/attachable_item', collection: @attachable_articles,
          item: :item, scrollable_div: '#attachable-articles-pagination .pagination', param_name: 'page_attach_art' } and return
    end
    @article_comments = @article.comments.order(created_at: :desc).paginate(page: params[:page], per_page: 5)
    @comment = current_user.comments.new if current_user
    @attachment = Attachment.new
    @attachments = Attachment.paginate(page: params[:page_attachment], per_page: 5)
    respond_to do |format|
      format.html
      format.js { render partial: 'shared/append_items', locals:
        { appendable_body: '.table-comments tbody', partial: 'articles/comment', collection: @article_comments,
          item: :comment, scrollable_div: '#infinite-scrolling .pagination', param_name: 'page' }
      }
    end
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles
  # POST /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: 'Article was successfully created.' }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1
  # PATCH/PUT /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: 'Article was successfully updated.' }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1
  # DELETE /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: 'Article was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
      params.require(:article).permit(:title, :content, :photo)
    end
end
