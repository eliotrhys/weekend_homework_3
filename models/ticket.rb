require_relative("../db/sqlrunner.rb")

class Ticket

  attr_accessor :id
  attr_accessor :customer_id, :film_id

  def initialize(options)
    @id = options['id'].to_i
    @customer_id = options['customer_id'].to_i
    @film_id = options['film_id'].to_i
  end

  def save
    sql = 'INSERT INTO tickets (
    customer_id,
    film_id
  )
  VALUES (
    $1, $2
  )
  RETURNING id'
  values = [@customer_id, @film_id]
  result = SqlRunner.run(sql, values).first
  @id = result['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM tickets'
    values = []
    result = SqlRunner.run(sql, values)
  end

end
