class SearchUsersForm
  include ActiveModel::Model
  include ActiveModel::Attributes

  attribute :name, :string
  attribute :role, :integer

  def search
    scope = User.distinct
    scope = scope.name_contain(name) if name.present?
    scope = scope.role_contain(role) if role.present?
    return scope
  end
end