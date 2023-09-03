export-env {
    use nu-goat-scripts shell_prompt
    shell_prompt setup --pwd-mode "git" --indicators {vi: {
        insert: " l> "
        normal: " l> "
    }}
}
