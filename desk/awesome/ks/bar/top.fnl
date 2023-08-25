(local awful (require :awful))
(local wibox (require :wibox))

(local gears (require :gears))

(local ks (require :ks/lib))

(local tasklist-buttons
  (gears.table.join
    (awful.button [] 1 #(if (= $ _G.client.focus) (tset $ :minimized true) ($:emit_signal :request::activate :tasklist {:raise true})))
    ))

(fn attach [screen]
  (local bar (awful.wibar {:position :top : screen}))
  (bar:setup
    (ks.container
      wibox.layout.align.horizontal
      (ks.container
        wibox.layout.fixed.horizontal
        (awful.widget.taglist
          {: screen
           :filter awful.widget.taglist.filter.all
           :widget_template
           (ks.widget wibox.container.background {:id :background_role}
                      (ks.widget wibox.container.margin {:left 12 :right 12}
                                 (ks.widget wibox.widget.textbox {:id :text_role})))})
        (awful.widget.tasklist
          {: screen
           :filter awful.widget.tasklist.filter.currenttags
           :buttons tasklist-buttons}))
      nil
      (ks.container
        wibox.layout.fixed.horizontal
        (ks.widget
          wibox.widget.textbox
          {:id :ks_prompt
           :text :prompthingy}))))
  bar)

attach
