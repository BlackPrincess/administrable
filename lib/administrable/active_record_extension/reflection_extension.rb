module Administrable::ActiveRecordExtension::ReflectionExtension
  def reflect_on_belongs_to_class(attr)
    reflect_on_belongs_to(attr).try(:klass)
  end
  
  def reflect_on_belongs_to(attr)
    reflect_on_all_associations(:belongs_to).find { |_| _.foreign_key == attr }
  end
  
  def reflect_on_belongs_to_attribute(attr)
    reflect_on_belongs_to(attr).try(:name)
  end

  def reflect_on_has_many_to_class(attr)
    reflect_on_has_many_to(attr).try(:klass)
  end

  def reflect_on_has_many_to(attr)
    reflect_on_all_associations(:has_many).find { |_| _.foreign_key == attr }
  end

  def reflect_on_has_many_to_attribute(attr)
    reflect_on_has_many_to(attr).try(:name)
  end
end

ActiveRecord::Base.extend(Administrable::ActiveRecordExtension::ReflectionExtension)
