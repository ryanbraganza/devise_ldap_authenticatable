require 'devise/strategies/authenticatable'

module Devise
  module Strategies
    # Strategy for signing in a user based on his login and password using LDAP.
    # Redirects to sign_in page if it's not authenticated
    class LdapAuthenticatable < Authenticatable
      # Authenticate a user based on login and password params, returning to warden
      # success and the authenticated user if everything is okay. Otherwise redirect
      # to sign in page.
      def authenticate!
        attributes = authentication_hash.dup.merge(:password => password)
        resource = valid_password? && mapping.to.authenticate_with_ldap(attributes)

        if validate(resource){ true }
          success!(resource)
        elsif !halted?
          fail(:invalid)
        end

      end
    end
  end
end

Warden::Strategies.add(:ldap_authenticatable, Devise::Strategies::LdapAuthenticatable)