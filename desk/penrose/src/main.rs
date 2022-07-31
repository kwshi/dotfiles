use penrose::{__private, validate_user_bindings};

use simplelog;

fn main() -> penrose::Result<()> {
    simplelog::SimpleLogger::init(simplelog::LevelFilter::Info, simplelog::Config::default())
        .unwrap();

    let cfg = penrose::Config::default()
        .builder()
        .bar_height(32)
        .border_px(4)
        .gap_px(4)
        .focused_border("#689d6a")?
        .unfocused_border("#32302f")?
        .layouts(vec![penrose::core::Layout::new(
            "main",
            penrose::core::layout::LayoutConf::default(),
            side_stack_alt,
            //penrose::core::layout::side_stack,
            1,
            0.6,
        )])
        .workspaces(["1", "2", "3", "4", "5"])
        .build()
        .unwrap();

    let kbs = penrose::gen_keybindings! {
        "M-Return" => penrose::run_external!("alacritty");
        "M-Tab" => penrose::run_internal!(cycle_client, penrose::Forward);
        "M-S-Tab" => penrose::run_internal!(cycle_client, penrose::Backward);
        "M-space" => penrose::run_external!("rofi -show run");
        "M-Escape" => penrose::run_internal!(exit);
        "M-e" => penrose::run_internal!(cycle_workspace, penrose::Forward);
        "M-q" => penrose::run_internal!(cycle_workspace, penrose::Backward);
        "M-v" => penrose::run_internal!(kill_client);
        "M-period" => penrose::run_internal!(update_main_ratio, penrose::More);
        "M-comma" => penrose::run_internal!(update_main_ratio, penrose::Less);
    };

    let hooks: penrose::core::hooks::Hooks<_> = vec![
        Box::new(bar(penrose::xcb::XcbDraw::new()?, &cfg)?),
        Box::new(Sct {}),
    ];

    let mut wm =
        penrose::xcb::new_xcb_backed_window_manager(cfg, hooks, penrose::logging_error_handler())?;

    wm.grab_keys_and_run(kbs, penrose::map! {})
}

fn side_stack_alt(
    clients: &[&penrose::core::Client],
    _: Option<penrose::Xid>,
    monitor_region: &penrose::core::data_types::Region,
    max_main: u32,
    ratio: f32,
) -> Vec<penrose::core::data_types::ResizeAction> {
    let n = clients.len() as u32;

    let momo = penrose::core::data_types::Region {
        x: monitor_region.x + 4,
        y: monitor_region.y + 4,
        w: monitor_region.w - 8,
        h: monitor_region.h - 8,
    };

    if n <= max_main || max_main == 0 {
        return momo
            .as_rows(n)
            .iter()
            .zip(clients)
            .map(|(r, c)| (c.id(), Some(*r)))
            .collect();
    }

    let split = ((momo.w as f32) * ratio) as u32;
    let (main, stack) = momo.split_at_width(split).unwrap();

    main.as_rows(max_main)
        .into_iter()
        .chain(stack.as_rows(n.saturating_sub(max_main)))
        .zip(clients)
        .map(|(r, c)| (c.id(), Some(r)))
        .collect()
}

struct Sct {}

impl<X: penrose::core::xconnection::XConn> penrose::core::Hook<X> for Sct {
    fn startup(&mut self, _: &mut penrose::WindowManager<X>) -> penrose::Result<()> {
        penrose::spawn!("sct", "3500")?;
        penrose::spawn!("alacritty")?;

        Ok(())
    }
}

fn bar<C, D, X>(
    draw: D,
    config: &penrose::Config,
) -> penrose::draw::Result<penrose::draw::StatusBar<C, D, X>>
where
    C: penrose::draw::DrawContext + 'static,
    D: penrose::draw::Draw<Ctx = C>,
    X: penrose::core::xconnection::XConn,
{
    let style = penrose::draw::TextStyle {
        font: "JuliaMono".to_string(),
        point_size: 12,
        fg: penrose::draw::Color::new_from_hex(0xebdbb2ff),
        bg: Some(penrose::draw::Color::new_from_hex(0x282828ff)),
        padding: (16.0, 10.0),
    };

    penrose::draw::StatusBar::try_new(
        draw,
        penrose::draw::Position::Top,
        (*config.bar_height()).try_into().unwrap(),
        penrose::draw::Color::new_from_hex(0x32302fff),
        &["JuliaMono"],
        vec![
            Box::new(Wgt { draw: true }),
            Box::new(penrose::draw::widget::base::InputBox::new(
                &style, false, false,
            )),
            Box::new(penrose::draw::widget::Workspaces::new(
                config.workspaces(),
                &style,
                penrose::draw::Color::new_from_hex(0x689d6aff),
                penrose::draw::Color::new_from_hex(0xebdbb2ff),
            )),
            Box::new(penrose::draw::widget::ActiveWindowName::new(
                &style, 80, true, false,
            )),
        ],
    )
}

struct Wgt {
    draw: bool,
}

impl penrose::draw::Widget for Wgt {
    fn draw(
        &mut self,
        ctx: &mut dyn penrose::draw::DrawContext,
        screen: usize,
        screen_has_focus: bool,
        w: f64,
        h: f64,
    ) -> penrose::draw::Result<()> {
        ctx.color(&penrose::draw::Color::new_from_hex(0xff0000ff));
        ctx.rectangle(0., 0., 10., 10.);
        ctx.font("JuliaMono", 12)?;
        ctx.text("hello", 2., (8., 8.))?;
        ctx.flush();
        self.draw = false;
        Ok(())
    }

    fn current_extent(
        &mut self,
        _ctx: &mut dyn penrose::draw::DrawContext,
        _h: f64,
    ) -> penrose::draw::Result<(f64, f64)> {
        Ok((20., 20.))
    }

    fn require_draw(&self) -> bool {
        self.draw
    }

    fn is_greedy(&self) -> bool {
        false
    }
}

impl<X: penrose::core::xconnection::XConn> penrose::core::Hook<X> for Wgt {}
