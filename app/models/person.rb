class Person < ActiveRecord::Base
  attr_accessor :position

  def self.process_parents(person, tree_array, position)
    mother = Person.find(person.parent_mother_id) rescue nil
    father = Person.find(person.parent_father_id) rescue nil
    if mother && father
      mother.position = position
      father.position = position
      tree_array.push(mother)
      tree_array.push(father)
    end
    new_position = position + 1
    if mother.parent_mother_id || mother.parent_father_id
      process_parents(mother, tree_array, new_position)
    end
    if father.parent_mother_id || father.parent_father_id
      process_parents(father, tree_array, new_position)
    end
  end

  def self.process_children(person, tree_array, position)
    children = Person.where("parent_mother_id = #{person.id} OR parent_father_id = #{person.id}")
    children.each do | person |
      person.position = position
      tree_array.push(person)
      new_position = position - 1
      Person.process_children(person, tree_array, new_position)
    end

  end

  def get_tree
    tree_array = []
    Person.process_parents(self, tree_array, 1)
    Person.process_children(self, tree_array, -1)
    self.position = 0
    tree_array.push(self)
    tree_array.sort_by! {|person| -person.position }
    return tree_array
  end

end

