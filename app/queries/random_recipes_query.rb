class RandomRecipesQuery
  def self.call(limit: 3)
    new.call(limit: limit)
  end

  def call(limit:)
    count = Recipe.count - limit
    random_offset = rand(count)
    Recipe.order(last_suggested_at: :asc).offset(random_offset).limit(limit).shuffle
  end
end
