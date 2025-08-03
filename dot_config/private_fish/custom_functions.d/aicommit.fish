function aicommit
    if git diff --cached --quiet
        echo "No changes in staged files for commit"
        return
    end

    set -l commit_msg (git diff --cached | aichat --role conventional-commit-message | string collect)

    echo $commit_msg
    read -n1 -P (set_color -o)"Commit? "(set_color normal)"["(set_color green)"y"(set_color normal)"es/"(set_color blue)"r"(set_color normal)"eword/"(set_color red)"N"(set_color normal)"o] " confirm
    switch $confirm
        case y Y
            git commit -m "$commit_msg"
        case r R
            git commit -e -m "$commit_msg"
        case n N "" '*'
            echo "Commit aborted"
    end
end
