require 'byebug'
class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[5, 3, 1], [], []]
  end

  def get_block(num)
    blocks = [@block1, @block2, @block3]
    idx = num - 1
    blocks[idx]
  end

  def move(from, to)


  end

  def valid_move?(from, to)
    return false if [from, to].any? { |num| num > 3 && num < 1 }
    return true if get_block(to).empty?
    return false if get_block(from).empty?

    if get_block(to).first < get_block(from).first
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
    @block1.empty? && (@block2.empty? || @block3.empty?)
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
game.display
