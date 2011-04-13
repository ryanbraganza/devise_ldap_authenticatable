Devise::Schema.class_eval do
  # Creates is_ldap
  def ldap_authenticatable(options={})
    null = options[:null] || false

    apply_devise_schema :is_ldap, :boolean, :null => null, :default => false
  end
 
end
