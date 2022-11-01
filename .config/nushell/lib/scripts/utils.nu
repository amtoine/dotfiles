export def has-env [variable: string] {
    $variable in (env).name
}
