#*
#*                  _    __ _ _
#*   __ _ ___  __ _| |_ / _(_) |___ ___  WEBSITE: https://goatfiles.github.io
#*  / _` / _ \/ _` |  _|  _| | / -_|_-<  REPOS:   https://github.com/goatfiles
#*  \__, \___/\__,_|\__|_| |_|_\___/__/  LICENCE: https://github.com/goatfiles/dotfiles/blob/main/LICENSE
#*  |___/
#*          MAINTAINERS:
#*              AMTOINE: https://github.com/amtoine antoine#1306 7C5EE50BA27B86B7F9D5A7BA37AAE9B486CFF1AB
#*              ATXR:    https://github.com/atxr    atxr#6214    3B25AF716B608D41AB86C3D20E55E4B1DE5B2C8B
#*

# TODO
export def "nu-complete help categories" [] {
    help commands | get category | uniq
}


# credit to @maximum
# https://discord.com/channels/601130461678272522/615253963645911060/1015477201359093851
export def hc [category?: string@"nu-complete help categories"] {
    help commands |
        select name category usage |
        move usage --after name |
        where category =~ $category
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1019056732841967647
export def-env up [nb: int = 1] {
    let path = (1..$nb | each {|_| ".."} | reduce {|it, acc| $acc + "/" + $it})
    cd $path
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1019056732841967647
export def-env mkcd [name: path] {
    cd (mkdir $name -s | first)
}


# credit to @/dev/adrien#4649
# https://discord.com/channels/601130461678272522/615253963645911060/1020549933792768060
export def set-screen [side: string = "right"] {
    if $side == "right" {
        xrandr --output HDMI-2 --auto --right-of eDP-1
    } else if $side == "left" {
        xrandr --output HDMI-2 --auto --left-of eDP-1
    } else {
        print "Side argument should be either \"right\" or \"left\"."
    }
}


# credit to @jon
# https://discord.com/channels/601130461678272522/615253963645911060/1022699054452461568
export def show_banner [] {
    let ellie = [
        "     __  ,"
        " .--()°'.'"
        "'|, . ,'  "
        ' !_-(_\   '
    ]
    let s = (sys)
    print $"(ansi reset)(ansi green)($ellie.0)"
    print $"(ansi green)($ellie.1)  (ansi yellow) (ansi yellow_bold)Nushell (ansi reset)(ansi yellow)v(version | get version)(ansi reset)"
    print $"(ansi green)($ellie.2)  (ansi light_blue) (ansi light_blue_bold)RAM (ansi reset)(ansi light_blue)($s.mem.used) / ($s.mem.total)(ansi reset)"
    print $"(ansi green)($ellie.3)  (ansi light_purple)ﮫ (ansi light_purple_bold)Uptime (ansi reset)(ansi light_purple)($s.host.uptime)(ansi reset)"
}


# credit to @azzamsa
# https://discord.com/channels/601130461678272522/988303282931912704/1026019048254873651
#
# slightly improved:
#   - does not use an extra br_cmd and alias
#   - allows the use of extra arguments, e.g. `br "-s"`
export def-env br [args = "."] {
    let cmd_file = (^mktemp | str trim);
    ^broot --outcmd $cmd_file $args;
    let cmd = ((open $cmd_file) | str trim);
    ^rm --trash $cmd_file;
    cd ($cmd | str replace "cd" "" | str trim)
}


# TODO
export def match [
    input:string
    matchers:record
    default?: block
] {
    if (($matchers | get -i $input) != null) {
         $matchers | get $input | do $in
    } else if ($default != null) {
        do $default
    }
}


# TODO
# credit to @Eldyj
# https://discord.com/channels/601130461678272522/614593951969574961/1039518281108815942
def mvr [
  path: string
  moveto: string
] {
  mv $path ($moveto | str replace % ($path | path dirname))
}


# TODO
# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1048654339494912031
export def "cross pathsep" [] {
  if ($nu.os-info.name =~ windows) {
    "\\"
  } else {
    "/"
  }
}


# TODO
# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1048654339494912031
export def "cross home" [] {
  if ($nu.os-info.name =~ windows) {
    $env.USERPROFILE
  } else {
    $env.HOME
  }
}


# TODO
# credit to @Eldyj
# https://discord.com/channels/601130461678272522/615253963645911060/1048654339494912031
export def "cross username" [] {
  if ($nu.os-info.name =~ windows) {
    $env.USERNAME
  } else {
    $env.USER
  }
}