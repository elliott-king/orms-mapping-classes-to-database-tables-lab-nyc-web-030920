class Student
  
  attr_accessor :name, :grade 
  attr_reader :id

  def initialize(name, grade, id=nil)
    @name = name
    @grade = grade 
    @id = id 
  end

  def save
    sql = <<-SQL 
      INSERT INTO students (name, grade)
      VALUES (?, ?)
      SQL
    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]
    # DB[:conn].execute("SELECT last_insert_rowid() FROM students") = [[1]]
  end

  def self.create_table
    sql = <<-SQL
      CREATE TABLE IF NOT EXISTS students (
        id INTEGER PRIMARY KEY,
        name TEXT,
        grade TEXT
      )
      SQL

    DB[:conn].execute(sql)
  end
  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end
  def self.create(name:, grade:)
    s = self.new(name, grade)
    s.save 
    return s
  end
  
end
