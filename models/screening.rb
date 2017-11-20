class Screening

  attr_reader :id
  attr_accessor :film_id, :start_time, :empty_seats

  def initialize(options)
    @id = options['id'].to_i
    @film_id = options['film_id'].to_i
    @start_time = options['start_time']
    @empty_seats = options['empty_seats'].to_i
  end

  def save
    sql = 'INSERT INTO screenings (
    film_id,
    start_time,
    empty_seats
  )
  VALUES (
    $1, $2, $3
  )
  RETURNING id'
  values = [@film_id, @start_time, @empty_seats]
  result = SqlRunner.run(sql, values).first
  @id = result['id'].to_i
  end

  def self.delete_all
    sql = 'DELETE FROM screenings'
    values = []
    result = SqlRunner.run(sql, values)
  end

  def self.all()
    sql = "SELECT * FROM screenings"
    values = []
    result = SqlRunner.run(sql, values)
    final_result = result.map { |screening| Screening.new( screening ) }
    return final_result
  end

end
