class Pokemon
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id: nil, name:, type:, db:, hp: 60)
    @id = id
    @hp = hp
    @name = name
    @type = type
    @db = db
  end

  def save
    if id.nil?
      @db.execute("INSERT INTO pokemon(name, type) VALUES ('#{@name}', '#{@type}')")
    else
      @db.execute("UPDATE pokemon SET name='#{name}', type='#{type}', hp='#{hp}' WHERE id=#{id};")
    end
  end

  def self.save(name, type, db)
    Pokemon.new(name: name, type: type, db: db).save
  end

  def self.find(id, db)
    id, name, type, hp = db.execute("SELECT * FROM pokemon WHERE id = #{id}").first
    Pokemon.new(id: id, name: name, type: type, db: db, hp: hp)
  end

  def alter_hp(value, db)
    self.hp = value
    self.save
  end
end
