require 'test_helper'

class Administrable::Field::Filter::RecordWithOperatorFilterTest < Test::Unit::TestCase
  test "edit field" do
    keys = ['id', 'name', 'created_at', 'updated_at', 'created_by', 'updated_by']
    filtted = Administrable::Field::Filter::RecordWithOperatorFilter.edit_field_filter(keys)
    assert_equal ['id', 'name', 'created_at', 'updated_at'], filtted
  end

  test 'field_type' do
    keys = ['id', 'name', 'created_at', 'updated_at', 'created_by', 'updated_by']
    filtted = Administrable::Field::Filter::RecordWithOperatorFilter.show_field_filter(keys)
    assert_equal keys, filtted
  end
end
