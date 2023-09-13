# encoding: UTF-8
# frozen_string_literal: true
%{█████████████████████████████████████████████████████████████████████████████}
#_█████████████████████████████████████████████████████████████████████████████
:_██████████████████████████████░░░████░░░░████░░░░████████████████████████████
"_█████████████████████████████░░██░██░░██░░██░░██░░███████████████████████████"
#_█████████████████████████████░░█████░░██████░░██░░███████████████████████████
%{█████████████████████████████░░█████░░█░░░██░░░░░████████████████████████████}
:_█████████████████████████████░░██░██░░██░░██░░███████████████████████████████
"_██████████████████████████████░░░████░░░░███░████████████████████████████████"
#_█████████████████████████████████████████████████████████████████████████████
%{█████████████████████████████████████████████████████████████████████████████
#%@╔════════════════════════════════════════════════════════════════════════╗%@#
%@#║                     * Character Gesture Patterns *                     ║@#%
@#%║                            Maxwell Wellman                             ║#%@
#%@║                                 1.0.0                                  ║%@#
%@#╚════════════════════════════════════════════════════════════════════════╝#%@
┌──────────────────────────────────────────────────────────────────────────────┐
│ C.G.P. is a flexible, customizable, expressive and feature-rich script that  │
│ replicates platforming movement from LISA: The Painful RPG.                  │
│                                                                              │
│ This script contains implementation code of the system. It is not supposed   │
│ to be directly edited. To update it to the latest version, simply copy and   │
│ paste the whole thing into this slot - leaving your developer config intact. │
│                                                                              │
│            CGP Config script and documentation can be found here:            │
│       ┌──────────────────────────────────────────────────────────────┐       │
│       │ https://github.com/MaxwellWellman/character-gesture-patterns │       │
│       └──────────────────────────────────────────────────────────────┘       │
│                                                                              │
│                 You can also ask for tech support in Discord:                │
│          ┌─────────────────────────────────────────────────────────┐         │
│          │ https://discord.gg/FahbHmYKMx?event=1060630490673057832 │         │
│          └─────────────────────────────────────────────────────────┘         │
└──────────────────────────────────────────────────────────────────────────────┘
}
#_█████████████████████████████████████████████████████████████████████████████
:_█████████████████████████████████████████████████████████████████████████████
"_███████████████████ I advise you not to edit the code below.█████████████████"
%{█████████████████████ It makes tech support MUCH harder. ████████████████████}
#_█ If you know Ruby and want to add features, make a separate add-on script ██
:_█████████████████████████████████████████████████████████████████████████████
"_█████████████████████████████████████████████████████████████████████████████"
%{█████████████████████████████████████████████████████████████████████████████}

$imported ||= {}; $imported[:cgp] = true

#───────────────────────────────────────────────────────────────────────────────
module CGP_Msg

  def self.error(str)
    msg = "\n\n\n\n\n\t\t┌───────────┐\n\t\t│ CGP ERROR │"
    msg.concat "\n\t\t└───────────┘\n\n\n\n\n"
    msg.concat "#{str}"
    # ┌─────────────────────────────────────────────────────────────┐
    # │ Hello                                                       │
    # │ If you are taken to this line after a crash,                │
    # │ there is something wrong with the way you set up CGP Config │
    # └─────────────────────────────────────────────────────────────┘
    raise msg # <--- if an error comes NOT from this line, report back to me
  end

  def self.warning(str)
    msg = "\n\n\n\n\n\t\t┌──────────────┐\n\t\t│ CGP  WARNING │"
    msg.concat "\n\t\t└──────────────┘\n\t"
    msg.concat "(this will only appear in test mode)"
    msg.concat "\t\t\t\t\t\t\t\t\t\t"
    msg.concat "\n\n\n\n\n"
    msg.concat "#{str}"
    msgbox msg if $TEST
  end

end

#───────────────────────────────────────────────────────────────────────────────
module SceneManager
  self.singleton_class.send :alias_method, :run___cgp, :run

  def self.run
    CGP_Config::init
    run___cgp
  end
end

#───────────────────────────────────────────────────────────────────────────────
class Spriteset_Map

  alias :load_tileset___cgp :load_tileset

  def load_tileset
    load_tileset___cgp
    tile_ids = (0..1663)
    autotile_ids = (2048..8191)
    counter_flag = 0x80
    counter_tiles = []
    star_flag = 0x10
    star_tiles = []
    parse = Proc.new { |i|
      unless (@tileset.flags[i] & counter_flag).zero?
        @tilemap.flags[i] = @tileset.flags[i] & ~counter_flag
        counter_tiles.push i
      end
      unless (@tileset.flags[i] & star_flag).zero?
        @tilemap.flags[i] = @tileset.flags[i] & ~star_flag
        star_tiles.push i
      end
    }
    tile_ids.each &parse
    autotile_ids.each &parse
    CGP_Map.class_variable_get(:@@preserved_tiles)[:counter] = counter_tiles
    CGP_Map.class_variable_get(:@@preserved_tiles)[:star] = star_tiles
  end

end

#───────────────────────────────────────────────────────────────────────────────
class Game_CharacterBase

  def shift_y
    0
  end

  alias :update___cgp :update

  def update
    update___cgp
    CGP_Char::update self
  end

  def update_bush_depth
    # disable Bush
    @bush_depth = 0
  end

  alias :set_direction___cgp :set_direction

  def set_direction d
    prev_d = @direction
    set_direction___cgp d
    straighten unless d == prev_d
  end

  alias :moveto___cgp :moveto

  def moveto x, y
    moveto___cgp x, y
    @y = y
    @real_x = x
    @real_y = y
    if x < 0
      x = 0
    end
    if x > $game_map.width - 1
      x = $game_map.width - 1
    end
    @x = x
  end

  def move_straight d, turn_ok = true
    CGP_Char::move_cardinal self, d
  end

  def move_diagonal horz, vert
    CGP_Char::move_diagonal self, horz, vert
  end

end

#───────────────────────────────────────────────────────────────────────────────
class Game_Character

  def jump x_plus, y_plus
    CGP_Char::jump self, x_plus, y_plus
  end

end

#───────────────────────────────────────────────────────────────────────────────
class Game_Map

  def counter? x, y
    return false unless valid? x, y
    return true if layered_tiles_flag? x, y, 0x80
    (layered_tiles(x, y) &
      CGP_Map.class_variable_get(:@@preserved_tiles)[:counter]
    ).any?
  end

  def display_x
    (@display_x * 32).floor.to_f / 32
  end

  def display_y
    (@display_y * 32).floor.to_f / 32
  end

  def adjust_x x
    if loop_horizontal? && x < display_x - (width - screen_tile_x) / 2
      x - display_x + @map.width
    else
      x - display_x
    end
  end

  def adjust_y y
    if loop_vertical? && y < display_y - (height - screen_tile_y) / 2
      y - display_y + @map.height
    else
      y - display_y
    end
  end

end

#───────────────────────────────────────────────────────────────────────────────
class Game_Player

  def check_event_trigger_there triggers
    # disable Counter
    x2 = $game_map.round_x_with_direction @x, @direction
    y2 = $game_map.round_y_with_direction @y, @direction
    start_map_event x2, y2, triggers, true
  end

  alias :update_jump___cgp :update_jump

  def update_jump
    update_jump___cgp
    if @jump_count == 0
      check_touch_event
    end
  end

end

#───────────────────────────────────────────────────────────────────────────────
class Game_Actor

  attr_accessor :cgp_config

  alias :setup___cgp :setup

  def setup(actor_id)
    setup___cgp actor_id
    @cgp_config = {}
    %w[
      complexion
      costume
    ].each do |type|
      @cgp_config[type.to_sym] = nil
      if /<cgp #{type}\s:(\w+)>/ =~ actor.note
        sym = "#{$1}".to_sym
        @cgp_config[type.to_sym] = sym
      end
    end
  end

  def check_floor_effect
    # disable Damage Floor
    nil
  end

end

#───────────────────────────────────────────────────────────────────────────────
module CGP_Config

  class << self

    def init
      unless $imported[:cgp_config]
        err = "CGP Config not found. CGP Main will have no effect."
        CGP_Msg::warning err
      end
    end

    def default_complexion
      {
        :gravity => :off
      }
    end

    def get_entry type_sym, item_sym
      entry = nil
      if self.const_defined? type_sym
        entry = self.const_get(type_sym)[item_sym]
      end
      entry || self.send("default_#{type_sym.to_s.downcase.chop}".to_sym)
    end

  end

end

#───────────────────────────────────────────────────────────────────────────────
module CGP_Map

  class << self

    @@preserved_tiles = {
      :counter => [],
      :star => []
    }

    def impasse? x, y, dir
      map = $game_map
      new_x = map.round_x_with_direction x, dir
      new_y = map.round_y_with_direction y, dir
      impasse = 0xF # [X] indoor wall
      tiles = map.layered_tiles new_x, new_y
      tiles.any? { |tile_id|
        map.tileset.flags[tile_id] & impasse == impasse
      }
    end

    def star_tile? x, y
      return false unless $game_map.valid? x, y
      ($game_map.layered_tiles(x, y) &
        CGP_Map.class_variable_get(:@@preserved_tiles)[:star]
      ).any?
    end

    def landing_position x, y
      map = $game_map
      until map.damage_floor? x, y
        y += 1
        if y >= map.height
          y += 3
          break
        end
      end
      [x, y - 1]
    end

    def get_markers regex
      # TODO multiple tags in one comment
      #  also get from map's note
      comment_code = 108
      markers = []
      $game_map.events.each { |ev_arr|
        event = ev_arr[1]
        rpg_event = event.instance_variable_get :@event
        rpg_event.pages.each { |page|
          page.list.each { |cmd|
            if cmd.code == comment_code
              text = cmd.parameters[0]
              if regex =~ text
                markers.push text
              end
            end
          }
        }
      }
      markers
    end

    def dir_to_int dir_text
      case dir_text
      when "down"
        2
      when "left"
        4
      when "right"
        6
      when "up"
        8
      end
    end

  end

end

#───────────────────────────────────────────────────────────────────────────────
module CGP_Char

  class << self

    def get_char_config_entry char, type_sym
      case true
      when char.is_a?(Game_Player) || char.is_a?(Game_Follower)
        actor = char.actor
        if actor.nil?
          nil
        else
          actor.cgp_config[type_sym]
        end
      when char.is_a?(Game_Vehicle)
        # TODO
      when char.is_a?(Game_Event)
        # TODO
      else
        #
      end
    end

    def get_prop char, type_sym, prop_sym, *args
      item_sym = get_char_config_entry char, type_sym
      item = CGP_Config::get_entry "#{type_sym.to_s.upcase}S", item_sym
      prop = item[prop_sym]
      unless prop.is_a? Proc
        return prop
      end
      prop.call char, *args
    end

    def move_freely char, dir
      char.set_direction dir
      x = $game_map.round_x_with_direction(char.x, dir)
      char.instance_variable_set :@x, x
      y = $game_map.round_y_with_direction(char.y, dir)
      char.instance_variable_set :@y, y
      char.increase_steps
    end

    def move_cardinal char, dir
      if char.debug_through?
        return move_freely char, dir
      end
      if CGP_Map::impasse? char.x, char.y, dir
        return dont_move char, dir
      end
      gravity = get_prop char, :complexion, :gravity
      if gravity == :on
        case dir
        when 2, 8
          move_vertical char, dir
        when 4, 6
          move_horizontal char, dir
        end
      else
        move_freely char, dir
      end
    end

    def move_horizontal char, dir
      x = $game_map.round_x_with_direction char.x, dir
      if $game_map.counter? x, char.y
        unless $game_map.damage_floor?(x, char.y + 1) or
          !$game_map.counter?(x, char.y + 1)
          return dont_move char, dir
        end
      end
      move_freely char, dir
    end

    def move_vertical char, dir
      dont_move char, dir
    end

    def move_diagonal char, dir_horz, dir_vert
      x = $game_map.round_x_with_direction char.x, dir_horz
      y = $game_map.round_y_with_direction char.y, dir_vert
      gravity = get_prop char, :complexion, :gravity
      if gravity == :on and $game_map.damage_floor? x, y
        return dont_move char, dir_horz
      end
      char.instance_variable_set :@x, x
      char.instance_variable_set :@y, y
      char.set_direction dir_horz
      char.increase_steps
    end

    def dont_move char, dir
      char.set_direction dir
      char.straighten
      unless char.direction_fix
        char.check_event_trigger_touch_front
      end
    end

    def update char
      update_auto_transfer char
      update_fall char
    end

    def update_auto_transfer char
      return unless char.is_a?(Game_Player) or char.is_a?(Game_Vehicle)
      # TODO for vehicles
      return if char.moving?
      return if char.jumping?
      return if char.y >= $game_map.height
      return if $game_map.valid? char.x, 0
      transfer_dir = 6
      if char.x < 0
        transfer_dir = 4
      end
      # TODO: vertical
      regex =
        /<cgp\sauto\stransfer\s(down|left|right|up)\s(\d+)(?:\sregion\s(\d+))?>/
      markers = CGP_Map::get_markers regex
      markers.each do |marker|
        if regex =~ marker
          dir = CGP_Map::dir_to_int "#{$1}"
          map_id = "#{$2}".to_i
          region_id = $3 ? "#{$3}".to_i : nil
          next unless dir == transfer_dir
          unless region_id.nil?
            next unless $game_map.region_id(char.x, char.y) == region_id
          end
          new_x = -1
          if transfer_dir == 4
            new_map = $game_map.load_data(
              sprintf("Data/Map%03d.rvdata2", map_id)
            )
            new_x = new_map.width
          end
          $game_temp.fade_type = 2
          $game_player.reserve_transfer map_id, new_x, char.y, transfer_dir
          return
        end
      end
      return_pos = transfer_dir == 6 ? $game_map.width : 0
      $game_player.set_direction $game_player.reverse_dir transfer_dir
      $game_player.instance_variable_set :@x, return_pos
    end

    def update_fall char
      return if char.debug_through?
      return if char.moving?
      return if char.jumping?
      gravity = get_prop char, :complexion, :gravity
      return unless gravity == :on
      if char.y >= $game_map.height
        return fall_off_map char
      end
      return unless $game_map.valid? char.x, char.y
      unless $game_map.damage_floor? char.x, char.y + 1
        x, y = CGP_Map::landing_position char.x, char.y + 1
        jump char, x - char.x, y - char.y
      end
    end

    def jump char, x_dist, y_dist
      x = char.x + x_dist
      y = char.y + y_dist
      gravity = get_prop char, :complexion, :gravity
      if gravity == :on
        unless $game_map.damage_floor?(x, y + 1) or !$game_map.valid?(0, y)
          x, y = CGP_Map::landing_position x, y + 1
        end
      end
      if x_dist < 0
        char.set_direction 4
      end
      if x_dist > 0
        char.set_direction 6
      end
      if x_dist == 0
        if y_dist < 0
          char.set_direction 8
        end
        if y_dist > 0
          char.set_direction 2
        end
      end
      jump_freely char, x - char.x, y - char.y
    end

    def jump_freely char, x_dist, y_dist
      char.instance_variable_set :@x, char.x + x_dist
      char.instance_variable_set :@y, char.y + y_dist
      distance = Math.sqrt(x_dist * x_dist + y_dist * y_dist).round
      jump_peak = 10 + distance - char.move_speed
      char.instance_variable_set :@jump_peak, jump_peak
      char.instance_variable_set :@jump_count, jump_peak * 2
      char.instance_variable_set :@stop_count, 0
      char.straighten
    end

    def fall_off_map char
      if char.is_a? Game_Player
        return SceneManager.goto Scene_Gameover
      end
      if char.is_a? Game_Event
        return char.erase
      end
      if char.is_a? Game_Vehicle
        #
      end
    end

  end

end

