use ../semver.nu [ "semver to-record" ]
use _test.nu

let tests = [
    [ name,                  input,         code,                 expected ];
    [ "invalid 1",           "foo",         { semver to-record }, { msg: "Cannot find column 'major'",             code: "nu::shell::column_not_found" } ],
    [ "invalid 2",           "1.2",         { semver to-record }, { msg: "Cannot find column 'major'",             code: "nu::shell::column_not_found" } ],
    [ "missing pre",         "1.2.3-+b",    { semver to-record }, { msg: "pre marker (-) is there but no pre",     code: null                          } ],
    [ "missing build",       "1.2.3-p+",    { semver to-record }, { msg: "build marker (+) is there but no build", code: null                          } ],
    [ "simple",              "1.2.3",       { semver to-record }, { major: 1, minor: 2, patch: 3, pre: "",    build: ""  } ],
    [ "pre",                 "1.2.3-p",     { semver to-record }, { major: 1, minor: 2, patch: 3, pre: "p",   build: ""  } ],
    [ "build",               "1.2.3+b",     { semver to-record }, { major: 1, minor: 2, patch: 3, pre: "",    build: "b" } ],
    [ "pre + build",         "1.2.3-p+b",   { semver to-record }, { major: 1, minor: 2, patch: 3, pre: "p",   build: "b" } ],
    [ "complex pre + build", "1.2.3-p.1+b", { semver to-record }, { major: 1, minor: 2, patch: 3, pre: "p.1", build: "b" } ],
]

$tests | _test run
