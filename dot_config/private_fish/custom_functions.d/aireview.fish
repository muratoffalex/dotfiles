# ref: https://github.com/IlyasYOY/dotfiles/blob/67eb33705aeed40e6640718da7617914fae0eb1a/sh/helpers.sh#L172
function aireview
    set -l diff_command (string escape -- $argv[1] || echo "git diff --cached")
    set -l diff_output (bash -c $diff_command | string collect)
    echo "Generated diff output." >&2
    set -l overview_output (echo $diff_output | aichat --role diff-overview $argv[2..-1] | string collect)
    echo "Generated overview output." >&2
    set -l comments_output (echo $diff_output | aichat --role diff-comments $argv[2..-1] | string collect)
    echo "Generated comments output." >&2

    echo -e "\n## Overview\n"
    echo $overview_output | perl -0777 -pe 's/<think>.*?<\/think>//sg'
    echo -e "\n\n## Comments\n"
    echo -e "<details><summary>Click to expand comments</summary>\n"
    echo $comments_output | perl -0777 -pe 's/<think>.*?<\/think>//sg'
    echo -e "\n</details>"

    set -l think_output_overview
    if string match -q -r "<think>" -- $overview_output
          set think_output_overview (echo $overview_output | perl -0777 -ne 'print "$1\n" while /<think>(.*?)<\/think>/gs' | string collect)
      end

      set -l think_output_comments
      if string match -q -r "<think>" -- $comments_output
          set think_output_comments (echo $comments_output | perl -0777 -ne 'print "$1\n" while /<think>(.*?)<\/think>/gs' | string collect)
      end

      if test -n "$think_output_overview" -o -n "$think_output_comments"
          echo -e "\n\n## Thinking Output\n"
          if test -n "$think_output_overview"
              echo -e "<details><summary>Overview thinking</summary>\n"
              echo $think_output_overview
              echo -e "\n</details>"
          end
          if test -n "$think_output_comments"
              echo -e "<details><summary>Comments thinking</summary>\n"
              echo $think_output_comments
              echo -e "\n</details>"
          end
      end
end
