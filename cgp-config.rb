# encoding: UTF-8
# frozen_string_literal: true
%{░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░}
#_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
:_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░███░░░░████░░░░████░░░░░░░░░░░░░░░░░░░░░░░░░░░░
"_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░█░░██░░██░░██░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░"
#_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░██░░░░░░██░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░
%{░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░░░░██░███░░█████░░░░░░░░░░░░░░░░░░░░░░░░░░░░}
:_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██░░█░░██░░██░░██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
"_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░███░░░░████░░░█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░"
#_░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
%{░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░
___╔════════════════════════════════════════════════════════════════════════╗___
___║                     * Character Gesture Patterns *                     ║___
___║                            Maxwell Wellman                             ║___
___║                           Developer Config                             ║___
___╚════════════════════════════════════════════════════════════════════════╝___
┌──────────────────────────────────────────────────────────────────────────────┐
│ C.G.P. is a flexible, customizable, expressive and feature-rich script that  │
│ replicates platforming movement from LISA: The Painful RPG.                  │
│                                                                              │
│   This script contains a customizable developer config. It is kept separate  │
│ from the main script to make updates easy and convenient. Include CGP Main   │
│ in your project for your configurations to go into effect.                   │
│                                                                              │
│             CGP Main script and documentation can be found here:             │
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
:_████████████████████████████_DEVELOPER_CONFIG_███████████████████████████████
"_█████████████████████████████████████████████████████████████████████████████"
module CGP_Config #────────────────────────────────────────────────────────────

  #
  #┌──────────────────────────────┐
  #│                              │
  #│                              │
  #│          add your            │
  #│      configurations here     │
  #│                              │
  #│                              │
  #└──────────────────────────────┘
  #

end #──────────────────────────────────────────────────────────────────────────
#_█████████████████████████████████████████████████████████████████████████████
:_███████████████████████████████████_END_█████████████████████████████████████
"_█████████████████████████████████████████████████████████████████████████████"
$imported ||= {}; $imported[:cgp_config] = true

module SceneManager
  class << self
    alias :run___cgp_config :run

    def run
      unless $imported[:cgp]
        msg = "\n\n\n\n\n\t\t┌──────────────┐\n\t\t│ CGP  WARNING │"
        msg.concat "\n\t\t└──────────────┘\n\t"
        msg.concat "(this will only appear in test mode)"
        msg.concat "\t\t\t\t\t\t\t\t\t\t"
        msg.concat "\n\n\n\n\n"
        msg.concat "CGP Main not found. CGP Config will have no effect."
        msgbox msg if $TEST
      end
      run___cgp_config
    end
  end
end