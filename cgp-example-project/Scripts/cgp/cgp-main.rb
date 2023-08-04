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
#%@║                                 0.0.1                                  ║%@#
%@#╚════════════════════════════════════════════════════════════════════════╝#%@
┌──────────────────────────────────────────────────────────────────────────────┐
│ C.G.P. is a flexible, customizable, expressive and feature-rich script that  │
│ replicates platforming movement from LISA: The Painful RPG.                  │
│                                                                              │
│ This script contains implementation code of the system. It is not supposed   │
│ to be directly edited. To update it to the latest version, simply copy and   │
│ paste the whole thing into this slot - leaving your developer config intact. │
│                                                                              │
│                                                                              │
│       If you don't have CGP Config, it can be found at the repository:       │
│       ┌──────────────────────────────────────────────────────────────┐       │
│       │ https://github.com/MaxwellWellman/character-gesture-patterns │       │
│       └──────────────────────────────────────────────────────────────┘       │
│                                                                              │
│                    Instructions and documentation here:                      │
│     ┌───────────────────────────────────────────────────────────────────┐    │
│     │ https://github.com/MaxwellWellman/character-gesture-patterns/wiki │    │
│     └───────────────────────────────────────────────────────────────────┘    │
│                                                                              │
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