local pl = require 'pl.import_into' ()

local colors_gruvbox = {
  {
    "f9f5d7",
    "fb4934",
    "fe8019",
    "fabd2f",
    "b8bb26",
    "8ec07c",
    "83a598",
    "d3869b",
    "1d2021",
  },
  {
    "fbf1c7",
    "cc241d",
    "d65d0e",
    "d79921",
    "98971a",
    "689d6a",
    "458588",
    "b16286",
    "282828",
  },
  {
    "f2e5bc",
    "9d0006",
    "af3a03",
    "b57614",
    "79740e",
    "427b58",
    "076678",
    "8f3f71",
    "32302f",
  },
  {
    "ebdbb2",
    "d5c4a1",
    "bdae93",
    "a89984",
    "928374",
    "7c6f64",
    "665c54",
    "504945",
    "3c3836",
  },
}

colors_ansi = {
  "282828",
  "cc241d",
  "98971a",
  "d79921",
  "458588",
  "b16286",
  "689d6a",
  "fbf1c7",
}
colors_ansi_bright = {
  "32302f",
  "fb4934",
  "b8bb26",
  "fabd2f",
  "83a598",
  "d3869b",
  "8ec07c",
  "f9f5d7",
}




function hex_to_rgb(hex)
  rgb = tonumber(hex, 16)
  return rgb >> 16 & 0xff, rgb >> 8 & 0xff, rgb & 0xff
end

function rgb_to_hex(r, g, b)
  return string.format("%06x", r << 16 | g << 8 | b)
end

function rgb_invert(r, g, b)
  return 0xff-r, 0xff-g, 0xff-b
end

function hex_invert(hex)
  return rgb_to_hex(rgb_invert(hex_to_rgb(hex)))
end

function hex_mag2(hex)
  r, g, b = hex_to_rgb(hex)
  return r^2 + g^2 + b^2
end

function hex_bg_to_fg(hex)
  if hex_mag2(hex) > 2 * 0xff^2 then
    return "1d2021"
  else
    return "fbf1c7"
  end
end

function render_row(yield, row)
  blocks = {}
  labels = {}
  for _, cell in ipairs(row) do
  	table.insert(
  		blocks,
  		string.format(
  			"${color %s}%s${color}",
  			cell.color,
  			string.rep("█", string.len(cell.label))
  		)
  	)
  	table.insert(
  		labels,
  		string.format(
        "${color %s}%s${color}",
        hex_bg_to_fg(cell.color),
        cell.label
      )
  	)
  end
  yield(table.concat(blocks, ""))
  yield("${voffset -18}" .. table.concat(labels, "") .. "${voffset 2}")
end

function render_rows(yield, rows)
  for _, row in ipairs(rows) do
    render_row(yield, row)
  end
end

function row_from_hex(row)
  return pl.tablex.map(function(hex)
    return {
      label=string.format(" %s ", hex),
      color=hex,
    }
  end, row)
end

function row_from_ansi(row, bright)
  local b = bright and 60 or 0
  print(require 'inspect'(row))
  return pl.tablex.pairmap(function(i, hex)
    return {
      label=string.format(" %2d  %3d ", 30+b+i-1, 40+b+i-1),
      color=hex,
    }
  end, row)
end

return function(yield)
  render_rows(yield, pl.tablex.map(row_from_hex, colors_gruvbox))
  render_row(yield, row_from_ansi(colors_ansi))
  render_row(yield, row_from_ansi(colors_ansi_bright, true))
end
