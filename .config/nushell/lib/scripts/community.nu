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
    ^rm $cmd_file;
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