const IGNORE = [ "_run", "_test" ]

let test_files = $env.CURRENT_FILE
    | path dirname
    | ls $in
    | get name
    | where { |it| $it | path parse | $in.stem not-in $IGNORE }

mut good = true

for f in $test_files {
    print $"(ansi purple)($f)(ansi reset)"
    let failed_tests = ^$nu.current-exe $f | from json | where not passed

    if ($failed_tests | is-empty) {
        continue
    }

    $good = false
    print $"(ansi red_reverse)woospies(ansi reset)"

    for t in $failed_tests {
        $t.expected | to nuon --indent 4 | save --force /tmp/expected
        $t.actual | to nuon --indent 4 | save --force /tmp/actual
        let diff = diff /tmp/actual /tmp/expected --color=always -u
            | lines
            | skip 3
            | each { '    ' + $in }
            | str join "\n"
        print $"  name: ($t.name)"
        print $"  input: ($t.input)"
        print $"  code: ($t.code | nu-highlight)"
        print $diff
    }
}

if not $good {
    exit 1
}
