require 'test_helper'

class Administrable::Field::BasicFieldTest < Test::Unit::TestCase
  test "edit field" do
    assert_false Administrable::Field::BasicField.edit_fields(Company.new).include?('id')
    assert Administrable::Field::BasicField.edit_fields(Company.new).include?('name')
  end
  
  test 'field_type' do
    assert_equal :belongs_to, Administrable::Field::BasicField.field_type(Member, 'company_id')
    assert_not_equal :belongs_to, Administrable::Field::BasicField.field_type(Member, 'name')
  end
end
