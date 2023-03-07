(local awful (require :awful))
(local wibox (require :wibox))
(local gears (require :gears))
(local beautiful (require :beautiful))

(local {: widget : container} (require :ks.lib))

(fn new []
  (var subscribe-pid nil)
  (local slider
    (wibox.widget
      {:widget wibox.widget.slider
       :id :ks_volume_slider
       :forced_width 128
       :handle_shape gears.shape.circle
       :bar_height 3}))

  (local w
    (wibox.widget
    (widget
      wibox.container.background {:id :ks_volume_background
                                  :bg :#076678
                                  :fg beautiful.ks/volume_fg}
      (widget
        wibox.container.margin {:left 8 :right 8}
        (container
          wibox.layout.fixed.horizontal
          (widget wibox.widget.textbox {:text "vol"})
          slider
          (widget wibox.widget.textbox {:text "?" :id :ks_volume_text})
          (widget wibox.widget.textbox {:text "%"}))))))

  (fn slider-to-volume []
    (awful.spawn [:pamixer :--set-volume (tostring slider.value)]))

  (fn volume-to-slider []
    (awful.spawn.easy_async
      [:pamixer :--get-volume]
      #(let [volume (tonumber $)]
         (each [_ t (ipairs (w:get_children_by_id :ks_volume_text))]
           (set t.text (tostring volume)))
         (set slider.value volume)))
    (awful.spawn.easy_async
      [:pamixer :--get-mute]
      #(match ($:match "^%s*(.-)%s*$")
         :true (each [_ b (ipairs (w:get_children_by_id :ks_volume_background))]
                 (set b.fg beautiful.ks/volume_mute_fg))
         :false (each [_ b (ipairs (w:get_children_by_id :ks_volume_background))]
                  (set b.fg beautiful.ks/volume_fg)))))

  (fn subscribe-callback [line]
    (if (~= nil (line:find "^Event 'change' on sink #"))
      (volume-to-slider)))

  (fn start-subscribe []
    (set subscribe-pid
         (awful.spawn.with_line_callback
           [:pactl :subscribe]
           {:stdout subscribe-callback})))

  (fn stop-subscribe []
    (if (~= subscribe-pid nil)
      (awful.spawn [:kill (tostring subscribe-pid)])))

  (slider:connect_signal :property::value slider-to-volume)

  ; doesn't trigger: see <https://github.com/awesomeWM/awesome/issues/1241>.
  ; ideally we want to run `slider-to-volume` only after button release, so as
  ; to avoid the rubber-banding race issue (where slider-triggered volume
  ; changes immediately propagate back to subscribe and tries to pull the slider
  ; back).  the other fix is to disconnect/disable the subscriber on button::
  ; press and reconnect it on release.
  ;(slider:connect_signal :button::release #(awful.spawn "notify-send release"))

  (_G.awesome.connect_signal :startup start-subscribe)
  (_G.awesome.connect_signal :startup volume-to-slider)
  (_G.awesome.connect_signal :exit stop-subscribe)

  w)

{: new}
