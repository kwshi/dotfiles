use readline-binding
use github.com/zzamboni/elvish-modules/alias

use github.com/zzamboni/elvish-completions/cd
use github.com/zzamboni/elvish-completions/git
use github.com/zzamboni/elvish-completions/ssh

-exports- = (alias:export)

edit:insert:binding[Alt-f]         = $edit:move-dot-right-small-word~
edit:insert:binding[Alt-b]         = $edit:move-dot-left-small-word~
edit:insert:binding[Alt-d]         = $edit:kill-small-word-right~
edit:insert:binding[Alt-Backspace] = $edit:kill-small-word-left~

fn spawn [prog @args]{
  nohup $prog $@args > /dev/null 2> /dev/null &
}


E:GOPATH = ~/go

E:PATH = ~'/bin:'$E:GOPATH'/bin:'$E:PATH

E:EDITOR = nvim

