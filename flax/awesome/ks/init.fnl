(local gears (require :gears))
(local awful (require :awful))
(local wibox (require :wibox))
(local beautiful (require :beautiful))
(local naughty (require :naughty))
(local menubar (require :menubar))

(local ks/bar/top (require :ks.bar.top))
(local ks/bar/bottom (require :ks.bar.bottom))

(require :awful.autofocus)

(local root _G.root)
(local awesome _G.awesome)

(local awful/hp (require :awful.hotkeys_popup))
(local awful/hp/keys (require :awful.hotkeys_popup.keys))

(beautiful.init (require :ks.theme))
(root.keys (require :ks.keys))

(set menubar.utils.terminal :alacritty)

(fn with-layout [layout ...]
  (let [tbl [...]] (set tbl.layout layout) tbl))

(fn widget [class props children]
  (let [w {:widget class}]
    (each [k v (pairs props)] (tset w k v))
    (each [i v (ipairs children)] (tset w i v))
    w))

(awful.screen.connect_for_each_screen
  (fn [screen]
    (awful.tag [:1 :2 :3 :4 :5] screen awful.layout.suit.tile)

    (local top-bar (ks/bar/top screen))
    (ks/bar/bottom screen)


    ))

(_G.client.connect_signal :focus #(do (set $.border_color beautiful.border_focus)))
(_G.client.connect_signal :unfocus #(do (set $.border_color beautiful.border_normal)))

(set awful.rules.rules
     [{:rule {}
       :properties {:screen awful.screen.preferred
                    :border_width beautiful.border_width
                    :border_color beautiful.border_normal
                    :focus awful.client.focus.filter
                    :size_hints_honor false}}
      ]
     )

(gears.wallpaper.set "#32302f")
