export const LETTERS = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ" | split chars
export const DIGITS = "0123456789" | split chars
export const SYMBOLS = "&#()?!@$%*_-" | split chars

export def "random ascii" [
    --length: int = 128,
    --alphabet: list<string> = ($LETTERS ++ $DIGITS ++ $SYMBOLS),
]: [ nothing -> string ] {
    random dice --dice $length --sides ($alphabet | length | $in)
        | each { $in - 1 }
        | each { |i| $alphabet | get $i }
        | str join
}
