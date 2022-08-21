# for more information on themes see
# https://www.nushell.sh/book/coloring_and_theming.html
export def dark [] {
    {
        # color for nushell primitives
        separator: white
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: green_bold
        empty: blue
        bool: white
        int: white
        filesize: white
        duration: white
        date: white
        range: white
        float: white
        string: white
        nothing: white
        binary: white
        cellpath: white
        row_index: green_bold
        record: white
        list: white
        block: white
        hints: dark_gray

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: purple_bold
        shape_bool: light_cyan
        shape_int: purple_bold
        shape_float: purple_bold
        shape_range: yellow_bold
        shape_internalcall: cyan_bold
        shape_external: cyan
        shape_externalarg: green_bold
        shape_literal: blue
        shape_operator: yellow
        shape_signature: green_bold
        shape_string: green
        shape_string_interpolation: cyan_bold
        shape_datetime: cyan_bold
        shape_list: cyan_bold
        shape_table: blue_bold
        shape_record: cyan_bold
        shape_block: blue_bold
        shape_filepath: cyan
        shape_globpattern: cyan_bold
        shape_variable: purple
        shape_flag: blue_bold
        shape_custom: green
        shape_nothing: light_cyan
    }
}

export def light [] {
    {
        # color for nushell primitives
        separator: dark_gray
        leading_trailing_space_bg: { attr: n } # no fg, no bg, attr none effectively turns this off
        header: green_bold
        empty: blue
        bool: dark_gray
        int: dark_gray
        filesize: dark_gray
        duration: dark_gray
        date: dark_gray
        range: dark_gray
        float: dark_gray
        string: dark_gray
        nothing: dark_gray
        binary: dark_gray
        cellpath: dark_gray
        row_index: green_bold
        record: white
        list: white
        block: white
        hints: dark_gray

        # shapes are used to change the cli syntax highlighting
        shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
        shape_binary: purple_bold
        shape_bool: light_cyan
        shape_int: purple_bold
        shape_float: purple_bold
        shape_range: yellow_bold
        shape_internalcall: cyan_bold
        shape_external: cyan
        shape_externalarg: green_bold
        shape_literal: blue
        shape_operator: yellow
        shape_signature: green_bold
        shape_string: green
        shape_string_interpolation: cyan_bold
        shape_datetime: cyan_bold
        shape_list: cyan_bold
        shape_table: blue_bold
        shape_record: cyan_bold
        shape_block: blue_bold
        shape_filepath: cyan
        shape_globpattern: cyan_bold
        shape_variable: purple
        shape_flag: blue_bold
        shape_custom: green
        shape_nothing: light_cyan
    }
}

export alias base00 = "#181818" # Default Background
export alias base01 = "#282828" # Lighter Background (Used for status bars, line number and folding marks)
export alias base02 = "#383838" # Selection Background
export alias base03 = "#585858" # Comments, Invisibles, Line Highlighting
export alias base04 = "#b8b8b8" # Dark Foreground (Used for status bars)
export alias base05 = "#d8d8d8" # Default Foreground, Caret, Delimiters, Operators
export alias base06 = "#e8e8e8" # Light Foreground (Not often used)
export alias base07 = "#f8f8f8" # Light Background (Not often used)
export alias base08 = "#ab4642" # Variables, XML Tags, Markup Link Text, Markup Lists, Diff Deleted
export alias base09 = "#dc9656" # Integers, Boolean, Constants, XML Attributes, Markup Link Url
export alias base0a = "#f7ca88" # Classes, Markup Bold, Search Text Background
export alias base0b = "#a1b56c" # Strings, Inherited Class, Markup Code, Diff Inserted
export alias base0c = "#86c1b9" # Support, Regular Expressions, Escape Characters, Markup Quotes
export alias base0d = "#7cafc2" # Functions, Methods, Attribute IDs, Headings
export alias base0e = "#ba8baf" # Keywords, Storage, Selector, Markup Italic, Diff Changed
export alias base0f = "#a16946" # Deprecated, Opening/Closing Embedded Language Tags, e.g. <?php ?>

export alias base16 = {
    separator: $base03
    leading_trailing_space_bg: $base04
    header: $base0b
    date: $base0e
    filesize: $base0d
    row_index: $base0c
    bool: $base08
    int: $base0b
    duration: $base08
    range: $base08
    float: $base08
    string: $base04
    nothing: $base08
    binary: $base08
    cellpath: $base08
    hints: dark_gray

    # shape_garbage: { fg: $base07 bg: $base08 attr: b} # base16 white on red
    # but i like the regular white on red for parse errors
    shape_garbage: { fg: "#FFFFFF" bg: "#FF0000" attr: b}
    shape_bool: $base0d
    shape_int: { fg: $base0e attr: b}
    shape_float: { fg: $base0e attr: b}
    shape_range: { fg: $base0a attr: b}
    shape_internalcall: { fg: $base0c attr: b}
    shape_external: $base0c
    shape_externalarg: { fg: $base0b attr: b}
    shape_literal: $base0d
    shape_operator: $base0a
    shape_signature: { fg: $base0b attr: b}
    shape_string: $base0b
    shape_filepath: $base0d
    shape_globpattern: { fg: $base0d attr: b}
    shape_variable: $base0e
    shape_flag: { fg: $base0d attr: b}
    shape_custom: {attr: b}
}
