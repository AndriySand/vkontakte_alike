class CommentsController < ApplicationController
  before_action :set_comment, only: [:update, :destroy]
  before_action :find_article

  # POST /comments
  # POST /comments.json
  def create
    @comment = @article.comments.new(comment_params)

    respond_to do |format|
      if @comment.save
        format.html { redirect_to @article }
        format.js
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.html { render inline: "<td class='comment-content' id='comment-<%= @comment.id %>'><%= @comment.content %></td>" }
        format.js
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article }
      format.js { render js: "$('#tr-comment-#{@comment.id}').remove();" }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :author_id)
    end

    def find_article
      @article = Article.find(params[:article_id])
    end

end
