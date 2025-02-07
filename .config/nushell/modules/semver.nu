export def "semver to-record" []: string -> record<> {
    let str = $in
    let res = $str
        | parse --regex '(?<major>\d+)\.(?<minor>\d+)\.(?<patch>\d+)(?<pre>-[\w.\d]+)?(?<build>\+[\w.\d]+)?'
        | into record
        | into int major
        | into int minor
        | into int patch
        | update pre { str replace --regex '^-' '' }
        | update build { str replace --regex '^\+' '' }

    if $res.pre == "" and ($str | str contains '-') {
        error make --unspanned { msg: "pre marker (-) is there but no pre" }
    }
    if $res.build == "" and ($str | str contains '+') {
        error make --unspanned { msg: "build marker (+) is there but no build" }
    }

    $res
}
