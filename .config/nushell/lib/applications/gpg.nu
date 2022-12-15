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

# TODO: documentation
def poll_gpg [
  key: string = ""
] {
  if ($key == "") {
    gpg --list-keys --with-colons
  } else {
    gpg --list-keys --with-colons $key
  }
}


# TODO: documentation
def get_gpg_tru [] {
  poll_gpg | lines | find --regex "^tru" | split column ":" --collapse-empty a b c d e f g
}


# TODO: documentation
def get_gpg_keys [] {
  poll_gpg | lines | find --regex "^pub" | parse "{pub}:{1}:{2}:{3}:{key}:{rest}" | get key
}


# TODO: documentation
def get_section [
  section: string
  context: int = 1
] {
  grep $"^($section)" -A $context | str trim
}


# TODO: documentation
def format_section [
  section: list  # list<string>
] {
  {
    main: ($section | get 0 | split column ":" --collapse-empty a b c d e f g h i j k)
    fpr: ($section | get 1 | split column ":" --collapse-empty a b)
  }
}


# TODO: documentation
def get_gpg_pub [
  key: string
] {
  let pub = (poll_gpg $key | get_section "pub" | lines)
  format_section $pub
}


# TODO: documentation
def get_gpg_sub [
  key: string
] {
  let sub = (poll_gpg $key | get_section "sub" | lines)
  format_section $sub
}


# TODO: documentation
def get_gpg_uid [
  key: string
] {
  poll_gpg $key | get_section "uid" | split column ":" --collapse-empty a b c d name e f g h i j
}


# TODO: documentation
def get_gpg_keys_data [] {
  (get_gpg_keys)
  | each {|key|
    {
      key: $key
      data: {
        pub: (get_gpg_pub $key)
        sub: (get_gpg_sub $key)
        uid: (get_gpg_uid $key)
      }
    }
  }
}


# TODO: documentation
export def list [] {
  {
    tru: (get_gpg_tru)
    keys: (get_gpg_keys_data)
  }
}