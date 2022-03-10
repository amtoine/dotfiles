#!/usr/bin/env fish

function line ()
  set t (echo "$argv" | awk '{print $1}')
  set a (echo "$argv" | awk '{print $2}')
  set b (echo "$argv" | awk '{print $3}')
  for i in (seq 1 2)
      for color in (echo "$t" | awk -F, -v var="$a" '{for (i = var; i < var + 2; i++) print $i}')
          set_color -b "$color"
          echo -n "    "
      end
      for color in (echo "$t" | awk -F, -v c="$b" '{for (i = c; i < c + 8; i++) print $i}')
          set_color -b "$color"
          echo -n "    "
      end
      echo ""
  end
end

function theme ()
  echo "$argv" | awk -F, '{print $1}'
  line "$argv" "2" "6"
  line "$argv" "4" "14"
  set_color normal
  echo ""
  echo ""
end

theme "$argv"
