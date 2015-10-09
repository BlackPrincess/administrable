require 'test_helper'

class Administrable::Field::BasicFilterTest < Test::Unit::TestCase
  test "edit field" do
    keys = ['id', 'name', 'created_at', 'updated_at']
    filtted = Administrable::Field::BasicFilter.edit_field_filter(keys)
    assert_equal ['name'], filtted
  end

  test 'field_type' do
    keys = ['id', 'name', 'created_at', 'updated_at']
    filtted = Administrable::Field::BasicFilter.show_field_filter(keys)
    assert_equal ['name', 'created_at', 'updated_at'], filtted
  end
end
