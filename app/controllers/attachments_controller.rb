class AttachmentsController < ApplicationController
  before_action :find_article

  def create
    @attachment = @article.attachments.new(attachment_params)

    respond_to do |format|
      if @attachment.save
        format.html { redirect_to @article, notice: 'You successfully uploaded file' }
        format.js
      else
        format.html { redirect_to @article, alert: @attachment.errors.messages[:asset] }
      end
    end
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def attachment_params
      params.require(:attachment).permit(:attachable_id, :author_id, :attachable_type, :asset)
    end

    def find_article
      @article = Article.find(params[:article_id])
    end

end
