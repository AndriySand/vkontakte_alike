class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can [:update, :edit, :destroy, :create], [Article, Comment], author_id: user.id
  end
end
