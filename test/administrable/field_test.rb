require 'test_helper'

class Administrable::FieldTest < ActiveSupport::TestCase
  test "edit field" do
    assert_not Administrable::Field.edit_fields(Company.new).include?('id')
    assert Administrable::Field.edit_fields(Company.new).include?('name')
  end
  
  test 'field_type' do
    assert_equal :belongs_to, Administrable::Field.field_type(Member, 'company_id')
    assert_not_equal :belongs_to, Administrable::Field.field_type(Member, 'name')
  end
end
