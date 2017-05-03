module UsersHelper

  def get_form_label(user)
    user.persisted? ? "Update user" : "Create user"
  end
end
