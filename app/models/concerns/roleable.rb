module Roleable
  extend ActiveSupport::Concern
  included do
    # List user roles
    ROLES = %i[admin supervisor operator].freeze

    # Json column for roles
    store_accessor :roles, *ROLES

    # Cast roles to/from booleans
    ROLES.each do |role|
      scope role, -> { where('roles @> ?', { role => true }.to_json) }
      define_method(:"#{role}=") { |value| super ActiveRecord::Type::Boolean.new.cast(value) }
      define_method(:"#{role}?") { send(role) }
    end

    # Where value true
    def active_roles
      ROLES.select { |role| send(:"#{role}?") }.compact
    end

    # Role validation
    validate :must_have_a_role, on: :update

    private

    def must_have_a_role
      errors.add(:base, 'A user must have at least one role') if roles.values.none?
    end
  end
end