require 'spec_helper'

describe User, :type => :model do
  it { is_expected.to allow_mass_assignment_of :email}
  it { is_expected.to allow_mass_assignment_of :password}
  it { is_expected.to allow_mass_assignment_of :password_confirmation}
  it { is_expected.to allow_mass_assignment_of :remember_me}

  pending "add some devise tests"
end
