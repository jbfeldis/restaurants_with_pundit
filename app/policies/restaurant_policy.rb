class RestaurantPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # show all restaurants
      # scope.all
      # in B2B SAAS app, show only the restaurants of the user
      if user.admin?
        scope.all
      else
        scope.where(user: user)
      end
    end
  end

  def create?
    true
  end

  def update?
    owner_or_admin?
  end

  def destroy?
    owner_or_admin?
  end

  def show?
    return true
  end

  private

  def owner_or_admin?
    user == record.user || user.admin?
  end
end
