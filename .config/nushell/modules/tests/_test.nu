export def run []: [
    table<name: string, input: string, code: closure, expected: any>
    -> string
] {
    insert actual { |t|
        print --stderr --no-newline $"running (ansi cyan)($t.name)(ansi reset)... "
        let actual = try {
            $t.input | do $t.code
        } catch {
            $in.json | from json | reject labels url help inner
        }

        if $actual == $t.expected {
            print --stderr $"(ansi green)passed(ansi reset)"
        } else {
            print --stderr $"(ansi red_bold)failed(ansi reset)"
        }

        $actual
    }
    | insert passed { $in.actual == $in.expected }
    | update code { view source $in }
    | to json
}
