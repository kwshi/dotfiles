(local awesome _G.awesome)
(local awful (require :awful))
(local gears (require :gears))

(local mod :Mod4)

(local bindings [])

(fn new-key [...]
  (each [_ v (ipairs (awful.key ...))]
    (table.insert bindings v)))

(new-key [:Mod4] :Return #(awful.spawn [:alacritty]))

(new-key [:Mod4] :Escape awesome.restart)

(each [key dir (pairs {:d :up :a :left :s :down :h :right})]
  (new-key [:Mod4 :Mod1] key #(awful.screen.focus_bydirection dir))
  (new-key [:Mod4] key #(awful.client.focus.global_bydirection dir))
  (new-key [:Mod4 :Shift] key #(awful.client.swap.global_bydirection dir))
  (new-key [:Mod4 :Mod1 :Control] key
           #(_G.client.focus:move_to_screen
              (_G.client.focus.screen:get_next_in_direction dir)))
)

;;(new-key [:Mod4] :1 #(awful.spawn :wezterm))

(new-key [:Mod4] :bracketleft #(awful.spawn.with_shell "maim -su | xclip -t image/png -selection clipboard"))

(new-key [:Mod4] :c #(if (~= _G.client.focus nil) (_G.client.focus:kill)))

(new-key [:Mod4] :Tab #(awful.client.focus.byidx 1))
(new-key [:Mod4 :Control] :Tab #(awful.client.focus.byidx -1))

(new-key [:Mod4] :f #(let [c _G.client.focus] (set c.fullscreen (not c.fullscreen)) (c:raise)))

(fn swap-tags [a b]
  (let [a-name a.name]
    (set a.name b.name)
    (set b.name a-name)
    (a:swap b)))

(fn swap-tag-relative [offset]
  (let [current-screen (awful.screen.focused {:client true})
        current-tag current-screen.selected_tag
        target-index (gears.math.cycle (length current-screen.tags)
                                    (+ current-tag.index offset))]
    (swap-tags current-tag (. current-screen.tags target-index))))

(fn move-to-tag-relative [offset]
  (let [current-screen (awful.screen.focused {:client true})
        current-tag current-screen.selected_tag
        target-index (gears.math.cycle (length current-screen.tags)
                                       (+ current-tag.index offset))
        target-tag (. current-screen.tags target-index)]
    (_G.client.focus:move_to_tag target-tag)
    (target-tag:view_only)))

(new-key [:Mod4] :r #(awful.tag.viewidx 1))
(new-key [:Mod4] :q #(awful.tag.viewidx -1))

(new-key [:Mod4 :Shift] :r #(swap-tag-relative 1))
(new-key [:Mod4 :Shift] :q #(swap-tag-relative -1))

(new-key [:Mod4 :Control] :r #(move-to-tag-relative 1))
(new-key [:Mod4 :Control] :q #(move-to-tag-relative -1))


(for [i 1 5]
  (new-key [:Mod4] (tostring i)
           #(let [scr (awful.screen.focused {:client true})
                  tag (. scr.tags i)]
              (tag:view_only)))
  (new-key [:Mod4 :Shift] (tostring i)
           #(let [scr (awful.screen.focused {:client true})]
              (swap-tags scr.selected_tag (. scr.tags i))))
  (new-key [:Mod4 :Control] (tostring i)
           #(let [scr (awful.screen.focused {:client true})
                  tag (. scr.tags i)]
              (_G.client.focus:move_to_tag tag)
              (tag:view_only))))


(new-key [] :XF86AudioRaiseVolume #(awful.spawn [:pamixer :--increase :5]))
(new-key [] :XF86AudioLowerVolume #(awful.spawn [:pamixer :--decrease :5]))
(new-key [] :XF86AudioMute #(awful.spawn [:pamixer :--toggle-mute]))

(new-key [:Mod4 :Shift] :Return #(awful.spawn ["rofi" "-show" "run"]))


bindings
