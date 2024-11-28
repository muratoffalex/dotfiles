function pack --description "Archive directory while excluding common dependency directories" --argument-names src dest
    # Common directories/files to exclude from archiving
    set --local excludes \
        --exclude='./vendor' \
        --exclude='./node_modules' \
        --exclude='.DS_Store' \
        --exclude='./Pods' \
        --exclude='./.cache' \
        --exclude='._*'
    tar $excludes -czf "$dest.tar.gz" "$src"
end
