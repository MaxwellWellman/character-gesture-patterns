# encoding: UTF-8
# frozen_string_literal: true
class Window_Base
  alias :initialize___zpt :initialize

  def initialize(x, y, width, height)
    initialize___zpt x, y, width, height
    self.back_opacity = 255
  end
end

class Window_TitleCommand
  alias :initialize___msd :initialize

  def initialize
    initialize___msd
    self.opacity = 0
    self.back_opacity = 0
  end

  alias :update_placement___kjh :update_placement

  def update_placement
    self.x = 20
    self.y = 20
  end

end

class Scene_Title
  alias :start___demo :start

  def start
    start___demo
    if $TEST
      command_new_game
    end
  end
end