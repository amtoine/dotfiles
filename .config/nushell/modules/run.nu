# run some code and notifies the end of the execution
export def run-and-notify [
    code: closure, # the piece of code to run
    name: string = "<unnamed>", # the name of the code to run
    --notifier (-N): string = "notify-send", # a command that takes a string argument and allows `--urgency critical`
] {
    try {
        do $code
        ^$notifier $name "done"
    } catch { |e|
        if $e == null {
            ^$notifier --urgency critical $name "???"
        } else {
            ^$notifier --urgency critical $name $e.msg
        }
    }
}
