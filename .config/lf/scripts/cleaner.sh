#!/bin/sh
# cirala -> https://github.com/cirala/lfimg/blob/master/cleaner 

if [ -n "$FIFO_UEBERZUG" ]; then
	printf '{"action": "remove", "identifier": "PREVIEW"}\n' > "$FIFO_UEBERZUG"
fi
