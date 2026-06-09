hl.bind(mainMod .. " + H",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + K",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + J",  hl.dsp.focus({ direction = "down" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

hl.bind(mainMod .. " + W", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle"}))
hl.bind(mainMod .. " + Q", hl.dsp.window.close())

hl.bind(mainMod .. " + Tab", hl.dsp.focus({ workspace = "previous" }))
hl.bind(mainMod .. " + SHIFT + Tab", hl.dsp.window.move({ workspace = "previous" }))
hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))
for i = 1, 6 do
  hl.bind(mainMod .. " + " .. i, hl.dsp.focus({ workspace = i}))
  hl.bind(mainMod .. " + SHIFT + " .. i, hl.dsp.window.move({ workspace = i }))
end

hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

hl.bind(mainMod .. " + D", hl.dsp.submap("display"))
hl.define_submap("display", function()
  hl.bind("escape", hl.dsp.submap("reset"))
  for i, v in ipairs(monitors) do
    hl.bind(tostring(i), v)
  end
end)

hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"), { locked = true })
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind(mainMod .. " + Right", hl.dsp.exec_cmd("playerctl next"), { locked = true })
hl.bind(mainMod .. " + Left", hl.dsp.exec_cmd("playerctl previous"), { locked = true })
hl.bind(mainMod .. " + Up", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 6%+"), { locked = true })
hl.bind(mainMod .. " + Down", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 6%-"), { locked = true })

hl.bind("XF86AudioRaiseVolume", hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { locked = true, repeating = true })
hl.bind("XF86AudioLowerVolume", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),      { locked = true, repeating = true })
hl.bind("XF86AudioMute",        hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),     { locked = true, repeating = true })
hl.bind("XF86AudioMicMute",     hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),   { locked = true, repeating = true })
hl.bind("XF86MonBrightnessUp",  hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),                  { locked = true, repeating = true })
hl.bind("XF86MonBrightnessDown",hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),                  { locked = true, repeating = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })

    -- $m+Shift+Escape exit
    -- $m+Escape exec ~/.config/wofi/power.sh
    --
    -- $m+quotedbl focus prev
    -- $m+Shift+h move left
    -- $m+Shift+j move down
    -- $m+Shift+k move up
    -- $m+Shift+l move right
    --
    -- $m+Shift+Left focus output left
    -- $m+Shift+Right focus output right
    --
    -- XF86AudioMute exec pactl set-sink-mute \@DEFAULT_SINK@ toggle
    -- XF86AudioLowerVolume exec pactl set-sink-volume \@DEFAULT_SINK@ -5%
    -- XF86AudioRaiseVolume exec pactl set-sink-volume \@DEFAULT_SINK@ +5%
    -- XF86AudioMicMute exec pactl set-source-mute \@DEFAULT_SOURCE@ toggle
    -- XF86AudioNext exec playerctl next
    -- XF86AudioPause exec playerctl play-pause
    -- XF86AudioPlay exec playerctl play-pause
    -- XF86AudioPrev exec playerctl previous
    -- XF86MonBrightnessDown exec brightnessctl -e4 -n2 set 5%-
    -- XF86MonBrightnessUp exec brightnessctl -e4 -n2 set 5%+
