(local ks (require :ks/lib))
(local awful (require :awful))
(local wibox (require :wibox))

(local widget/audio (require :ks/bar/widget/audio))

(fn attach [screen]
  (local bar (awful.wibar {:position :bottom : screen}))
  (bar:setup
    (ks.container
      wibox.layout.align.horizontal
      (ks.container
        wibox.layout.fixed.horizontal
        (ks.widget
          wibox.container.margin {:left 8 :right 8}
          {:widget wibox.widget.textclock
           :format "%F (%A) %T"
           :refresh 1})
        (widget/audio.new))
      nil
      (ks.container
        wibox.layout.fixed.horizontal
        {:widget wibox.widget.systray
         ;:base_size 16
         }))))

attach
