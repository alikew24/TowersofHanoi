require 'byebug'
require 'io/console'

class TowersOfHanoi
  attr_accessor :towers

  def initialize
    @towers = [[5, 3, 1], [], []]
  end

  def show_instructions
    system("clear")
    puts <<-HEREDOC
    In this game, the goal is to move all the disks from Tower 1
    to one of the other towers. You must adhere to the following rules:
      1. You can only move one disk at a time.
      2. A larger disk cannot be placed on top of a smaller disk.

    The disks are depicted as follows:
      Smallest disk: ♟
      Medium-sized disk: ♟♟♟
      Largest disk: ♟♟♟♟♟
    HEREDOC

    puts "\nPress any key to continue!"
    STDIN.getch
    system("clear")

    puts <<-HEREDOC
    To play, first select which tower you would like to move the disk
    from by typing '1', '2', or '3', and then pressing enter.

    Then, select which tower you would like to move that disk to.
    HEREDOC

    puts "\nPress any key to begin playing!"
    STDIN.getch
    system("clear")
  end

  def run
    self.show_instructions
    while (!self.has_won?)
      display
      puts "What tower would you like to move from?"
      from = gets.chomp.to_i - 1
      puts "What tower would you like to move to?"
      to = gets.chomp.to_i - 1
      if valid_move?(from, to)
        move(from, to)
        system("clear")
      else
        system("clear")
        puts "That is not a valid move"
      end
    end
    display
    puts "Congrats! You won the game!"
  end

  def move(from, to)
      @towers[to] << @towers[from].delete(@towers[from].last)
      #@towers[to] << @towers[from].pop
  end

  def valid_move?(from, to)
    return false if [from, to].any? { |num| num > 2 || num < 0 }
    return false if from == to
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
