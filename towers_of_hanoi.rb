require 'byebug'
class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[5, 3, 1], [], []]
  end

  def run
    while (!self.has_won?)
      display
      puts "What block would you like to move from?"
      from = gets.chomp.to_i - 1
      puts "What block would you like to move to?"
      to = gets.chomp.to_i - 1
      if valid_move?(from, to)
        move(from, to)
        display
      else
        puts "That is not a valid move"
      end
    end
    puts "congrats! You won the game!"
  end

  def move(from, to)
      @towers[to] << @towers[from].delete(@towers[from].last)
      #@towers[to] << @towers[from].pop
  end

  def valid_move?(from, to)
    return false if [from, to].any? { |num| num > 2 || num < 0 }
    return false if @towers[from].empty?
    return true if @towers[to].empty?

    if @towers[to].first < @towers[from].first
      return false
    else
      return true
    end
  end

  def display
    idx = @towers.length - 1
    while idx >= 0
      line = ""
      @towers.each do |tower|
        if tower[idx].nil?
          line << render_space_for_nil + "    "
        else
          line << render_disk(tower[idx]) + "    "
        end
      end
      puts line
      idx -= 1
    end
    tower_line = ""
    @towers.length.times do |num|
      tower_line << "Tower " + (num + 1).to_s + "    "
    end
    puts tower_line
  end

  def render_space_for_nil
    "       "
  end



  def has_won?
    @towers[0].empty? && (@towers[1].empty? || @towers[2].empty?)
  end


  def render_disk(num)
    spaces = render_outer_space(num)
    pawns = ""
    num.times do
      pawns << "\u265f"
    end
    spaces + pawns + spaces
  end

  def render_outer_space(num)
    num_spaces = (7 - num) / 2
    toRet = ""
    num_spaces.times do
      toRet << " "
    end
    toRet
  end
end


game = TowersOfHanoi.new
game.run
