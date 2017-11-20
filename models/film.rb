class Film

  attr_reader :id
  attr_accessor :title, :price

  def initialize(options)
    @id = options['id'].to_i
    @title = options['title']
    @price = options['price'].to_i
  end

  def save
    sql = 'INSERT INTO films (
      title,
      price
    )
    VALUES (
      $1, $2
    )
    RETURNING id'
    values = [@title, @price]
    result = SqlRunner.run(sql, values).first
    @id = result['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM films'
    values = []
    result = SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM films"
    values = []
    result = SqlRunner.run(sql, values)
    final_result = result.map { |film| Film.new( film ) }
    return final_result
  end

end
