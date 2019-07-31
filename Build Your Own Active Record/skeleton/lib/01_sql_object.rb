require_relative 'db_connection'
require 'active_support/inflector'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    return @col if @col
    @col = DBConnection.execute2(<<-SQL)
      SELECT
        *
      FROM
        #{table_name}
    SQL

    @col[0].map { |el| el.to_sym }
  end

  def self.finalize!
    cols = self.columns
    cols.each do |col|
      define_method("#{col}=") do |val|
        self.attributes[col] = val
      end

      define_method("#{col}") do
        self.attributes[col]
      end
    end
  end

  def self.table_name=(table_name)
    @table_name = table_name
  end

  def self.table_name
    @table_name ||= self.name.tableize
  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    params.each do |attr_name, value|
      unless self.tale_name.columns.include?(attr_name.to_sym)
        raise 'unknown attribute "#{attr_name}" '
      end

      self.send(attributes[k], v)
    end
  end

  def attributes
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end
