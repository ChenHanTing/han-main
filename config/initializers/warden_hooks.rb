# frozen_string_literal: true

Warden::Manager.after_set_user do |user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = user.id
end

Warden::Manager.before_logout do |_user, auth, opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = nil
end

Warden::Manager.after_authentication do |user, _auth, _opts|
  MemberLoginHistory.create!(
    login_member: user.username,
    login_at: user.current_sign_in_at
  )
end
