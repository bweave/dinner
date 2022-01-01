class RandomDinnersQuery
  def self.call(limit: 3)
    new.call(limit: limit)
  end

  def call(limit:)
    count = Dinner.count - limit
    random_offset = rand(count)
    Dinner.order(last_suggested_at: :asc).offset(random_offset).limit(limit).shuffle
  end
end
