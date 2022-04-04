#!/bin/bash
#this script daemonise mpv to use it as an audio (or video) player controllable by WM launchers or any terminal
#for instance, you can create a launcher for "mpvd.sh xclip" with a keyboard shortcut to be able to copy youtube links and play them dirrectly with mpv, thus replacing the defunct "play with mpv" browser extension
#you can also control the audio playback (next song, pause...) with  the same method (or just from any terminal or tty)
#you can also send playback control commands from a terminal (or WM) even thou mpvd is running in another terminal
#as the output of mpv is stored in a text file, you can use it to have your WM display the currently playing song (see spectrwm_bar_action.sh for an example)

#dependencies: 
	#empty (package name empty-expect for debian), 
	#mpv (obviously, but it should not require too much tweaking to use any CLI enabled player),
	#notify-send (and a notification daemon) (or you could just remove the lines where it is called)
	#socat

#usage:
	#see the case switch. use ctrl+C to detach, use q in an attached instance or run "mpvd.sh q" to quit.
	#you may need to run "reset" when mpvd quits, sometimes (I mean, this whole thing IS an ugly hack (but it seems to be empty's fault, it does not like the program it runs qitting by itself))
	
	#default_sink="alsa_output.usb-FiiO_FiiO_USB_DAC_Q1-01.analog-stereo"
	#useEQ="yes"
	useEQ="yes"
	maxres=1440
#we use a kind of lowpass filter when not called with xclip
#the volume (between 0 and 1) should be lowered as the gain is increased not to saturate
#about 0.07 for 17 dB of bass gain at 70 Hz
musicVolume=0.08 #0.1 with 17 dB of bass gain
#[dB] 0 Hz gain, default 14
bassGain=18 #17 avec les pad "cuir"
#cutoff frequency, default 80 or 65
bassCutoff=500 #40
icon_path="/usr/share/icons/hicolor/scalable/apps/mpv.svg" #for the notification

cleanup() {
	printf "\n\n\t-- cleaning up -- \n\n"
	pkill -F /tmp/mpv_daemon_pipe_cleaner.pid 2> /dev/null
	pkill -F /tmp/mpv_daemon_socat_in.pid  2> /dev/null
	pkill -F /tmp/mpv_daemon_socat_out.pid 2> /dev/null
	pkill -F /tmp/mpv_daemon.pid           2> /dev/null
	rm -f /tmp/mpv_daemon*

}

test_running() {
	if ! [ -p /tmp/mpv_daemon_in.fifo ]; then
		echo 'a daemonised mpv session does not seems to be running'
		echo '(could not find /tmp/mpv_daemon_in.fifo, or is not a FIFO)'
		exit 1
	fi
}



for arg in "$@"; do
	arg=$(echo "$arg" | sed -e 's/^-//' -e 's/^-//')
	case "$arg" in
		"next" | "n") 
			test_running
			echo '>' > /tmp/mpv_daemon_in.fifo
			sleep 0.2 #needed in case mpv starts playing an album cover, to let it time to go to the next file (set mf-fps to something above 1000 in your config to make mpv do that quickly)
			#send notification
			notify-send \
				-i "$icon_path"  \
				-t 2000 \
				'mpvd'\
			       	"$( sed /tmp/mpv_daemon.log -n -r -e 's/.*(Title: |Playing:(.*\/))(.*)/Playing: \3/p' | sed -e '$!d' )"  &
		       	exit 0
			;;
		"prev" | "previous" | "p")
			test_running
			echo '<<' > /tmp/mpv_daemon_in.fifo
		       	exit 0
			;;
		"pause" | "p")
			test_running
			echo 'p' > /tmp/mpv_daemon_in.fifo 
			exit 0
			;;
		"quit" | "q")
			echo 'q' > /tmp/mpv_daemon_in.fifo #let it quit cleanly..
			sleep 1
			cleanup
			exit 0
			;;
		"attach" | "a")
			test_running
			#kill the pipe cleaner
			pkill -F /tmp/mpv_daemon_pipe_cleaner.pid 2> /dev/null
			#read with a socat in a subshell, write with another one, as the data transfer is dirrectionnal
			#escape char is esc
			socat -u /tmp/mpv_daemon_out.fifo -,crlf &
			echo $! > /tmp/mpv_daemon_socat_out.pid

			#escape is ctrl+c (0x03)
			socat -u -,escape=0x03,rawer /tmp/mpv_daemon_in.fifo
			echo $! > /tmp/mpv_daemon_socat_in.pid

			#kill the output socat
			pkill -F /tmp/mpv_daemon_socat_out.pid 2> /dev/null
			pkill -F /tmp/mpv_daemon_socat_in.pid  2> /dev/null

			#read the output fifo from time to time to empty it (mpv will be put on hold if the fifo is full)
			exec cat /tmp/mpv_daemon_out.fifo > /dev/null 2> /dev/null & #it"s a fifo, cat won't exit unless empty exited
			echo $! > /tmp/mpv_daemon_pipe_cleaner.pid
			echo
			;;
		"no_daemon" ) #launch mpv, should be called by empty
			#	shift 

			#set default sink each playlist start. is the default sink is unavailable, pulse will complain and not change the sink
			#pacmd set-default-sink "$default_sink"
			shift
			if [[ "$useEQ" = "yes" ]] ; then
				echo "using EQ"

				mpv \
					--shuffle \
					--loop-playlist \
					--cache-secs=30 \
					--no-video \
				--af="\
aformat=sample_fmts=s32:sample_rates=96000,\
volume:volume=$musicVolume::precision=fixed,\
bass:gain=$bassGain:f=$bassCutoff" \
				"$@"
			else
				echo "not using EQ"
				mpv \
					--shuffle \
					--loop-playlist \
					--no-video \
					--cache-secs=30 \
					--af="\
aformat=sample_fmts=s32:sample_rates=96000,\
volume:precision=fixed"\
				"$@"
				#my DAC internally interpolates to S24 @96000 Hz, might as well do it before the EQs
			fi
			cleanup
			exit 0
			;;
		"xclip" ) #play the video URL or file path from the clipboard (requires xclip)
			#send notification, starting video playing might take some time
			notify-send -i $icon_path -t 3000 "mpvd" "Playing: $(xclip -o)" &
			pacmd set-default-sink "$default_sink" 
			if [ "$maxres" = 'best' ]; then
					echo "maxres=$maxres, using best resolution"
					#mpv $(xclip -o) --ytdl-format="bestvideo+bestaudio/best" --write-filename-in-watch-later-config\
					mpv $(xclip -o)\
					|| notify-send -i $icon_path "mpvd" "Error playing $(xclip -o)" &
				else
					echo "max resolution: $maxres"
					#mpv $(xclip -o) --ytdl-format="bestvideo[height<=?$maxres]+bestaudio/best" --write-filename-in-watch-later-config\
					mpv $(xclip -o) --ytdl-format="bestvideo[height<=?$maxres]+bestaudio/best" --write-filename-in-watch-later-config\
					|| notify-send -i $icon_path "mpvd" "Error playing $(xclip -o)" &
			fi
			exit 0
			;;
		"find" )
			shift
			#TODO tester plus
			searchterm="$1"
			echo "\$1=$1"
			shift
			echo "\$@=$@"
			echo $(find "$@" -iname "*$searchterm*" | sed "s#^#$PWD/#")
			exec $0 "$(find "$@" -iname "*$searchterm*" |  sed "s#^#$PWD/#g")"
			exec $0 attach
			;;
			* )
			cleanup
			empty -f -i /tmp/mpv_daemon_in.fifo -o /tmp/mpv_daemon_out.fifo -p /tmp/mpv_daemon.pid -L /tmp/mpv_daemon.log $0 no_daemon "$@"

			#launches the control script to get the output, as mpv was not daemonised.
			#if you don't want to attach it, remember to run the cat to empty the pipe
			exec $0 attach
			;;
* )
			cleanup
			empty -f -i /tmp/mpv_daemon_in.fifo -o /tmp/mpv_daemon_out.fifo -p /tmp/mpv_daemon.pid -L /tmp/mpv_daemon.log $0 no_daemon "$@"

			#launches the control script to get the output, as mpv was not daemonised.
			#if you don't want to attach it, remember to run the cat to empty the pipe
			exec $0 attach
			;;

	esac
	shift 
done
exit 0
