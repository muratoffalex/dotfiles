# https://alexwlchan.net/2023/forgetful-fish/
function forget_last_command --description 'Delete last command from history'
    set last_typed_command (history --max 1)
    history delete --exact --case-sensitive "$last_typed_command"
    true
end
