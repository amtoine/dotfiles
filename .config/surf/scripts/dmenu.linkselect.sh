#!/usr/bin/env sh
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

SURF_WINDOW="${1:-$(xprop -root | sed -n '/^_NET_ACTIVE_WINDOW/ s/.* //p')}"
DMENU_PROMPT="${2:-Link}"
DMFONT="mononoki Nerd Font-15"

dump_links_with_titles() {
  awk '{
    input = $0;

    $0 = input;
    gsub("<[^>]*>", "");
    gsub(/[ ]+/, " ");
    gsub("&amp;", "\\&");
    gsub("&lt;", "<");
    gsub("&gt;", ">");
    $1 = $1;
    title = ($0 == "" ? "None" : $0);

    $0 = input;
    match($0, /\<[ ]*[aA][^>]* [hH][rR][eE][fF]=["]([^"]+)["]/, linkextract);
    $0 = linkextract[1];
    gsub(/^[ \t]+/,"");
    gsub(/[ \t]+$/,"");
    gsub("[ ]", "%20");
    link = $0;

    if (link != "") {
      print title ": " link;
    }
  }'
}

link_normalize() {
  URI=$1
  awk -v uri=$URI '{
    gsub("&amp;", "\\&");

    if ($0 ~ /^https?:\/\//  || $0 ~ /^\/\/.+$/) {
      print $0;
    } else if ($0 ~/^#/) {
      gsub(/[#?][^#?]+/, "", uri);
      print uri $0;
    } else if ($0 ~/^\//) {
      split(uri, uri_parts, "/");
      print uri_parts[3] $0;
    } else {
      gsub(/[#][^#]+/, "", uri);
      uri_parts_size = split(uri, uri_parts, "/");
      delete uri_parts[uri_parts_size];
      for (v in uri_parts) {
        uri_pagestripped = uri_pagestripped uri_parts[v] "/"
      }
      print uri_pagestripped $0;
    }
  }'
}

link_select() {
  tr '\n\r' ' ' |
    xmllint --html --xpath "//a" - |
    dump_links_with_titles |
    awk '!x[$0]++' |
    # sort | uniq
    dmenu -p "$DMENU_PROMPT" -fn "$DMFONT" -l 10 -i -w $SURF_WINDOW |
    awk -F' ' '{print $NF}' |
    link_normalize $(xprop -id $SURF_WINDOW _SURF_URI | cut -d '"' -f 2)
}

link_select
