module GameHelper
  def game_start
    players=@game.players
    spy=players[Random.rand(players.count)]
    players.each do |player|
      player.role = player.id == spy.id ? 'spy' : 'detective'
      player.save
    end
  end
  def game_data
    spy=@game.players.find_by_role('spy')
    detectives=@game.players.where(role: 'detective')
    data={
      countdown: [0, @game.date_time_of_start + @game.length - Time.now].max,
      detectives: detectives.collect do |player|
        position=player.latest_position
        {
          user_id: player.user_id,
          latitude: position.latitude,
          longitude: position.longitude,
          name: player.user.name
        }
      end
    }
    if spy
      position=spy.latest_position(@game.spy_update_time(60))
      data[:spy]={
        user_id: spy.user_id,
        latitude: position.latitude,
        longitude: position.longitude,
        name: spy.user.name
      }
    end
    return data
  end
end
