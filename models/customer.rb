require_relative("../db/sqlrunner.rb")

class Customer

  attr_accessor :id
  attr_accessor :name, :funds, :tickets

  def initialize(options)
    @id = options['id'].to_i
    @name = options['name']
    @funds = options['funds'].to_i
    @tickets = []
  end

  def save
    sql = 'INSERT INTO customers (
    name,
    funds
  )
  VALUES (
    $1, $2
  )
  RETURNING id'
  values = [@name, @funds]
  result = SqlRunner.run(sql, values).first
  @id = result['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM customers'
    values = []
    result = SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM customers"
    values = []
    result = SqlRunner.run(sql, values)
    final_result = result.map { |customer| Customer.new( customer ) }
    return final_result
  end

  def buy_ticket(screening)
    result = @tickets << screening
    return result
  end

  def ticket_count
    result = @tickets.count
    return result
  end

end
