class UsersController < ApplicationController
  before_filter :set_user, except: :index

  def following
    @title = "Following Users"
    @users_articles_comments = find_article_and_comment(@user.followed_users)
    render 'show_follow'
  end

  def followers
    @title = "Followers Users"
    @users_articles_comments = find_article_and_comment(@user.followers)
    render 'show_follow'
  end

  def index
    @users = User.includes(:articles).paginate(page: params[:page], per_page: 10)
    respond_to do |format|
      format.html
    end
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 10)
  end

  private

    def set_user
      @user = User.find params[:id]
    end

    def find_article_and_comment(users)
      users.paginate(page: params[:page]).includes(articles: :comments).map do |user|
        [ user, user.articles.last, user.articles.last.try(:comments).try(:last) ]
      end
    end

end