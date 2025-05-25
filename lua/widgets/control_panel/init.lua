local App = require("astal.gtk3").App
local Widget = require("astal.gtk3").Widget
local Astal = require("astal.gtk3").Astal
local Gdk = require("astal.gtk3").Gdk
local Gtk = require("astal.gtk3").Gtk

local NotificationList = require("lua.widgets.control_panel.notification_list")
local AudioSliders = require("lua.widgets.control_panel.audio_sliders")

local function hide()
	local panel = App:get_window("Control-panel")
	if panel then panel:hide() end
end

local function WifiButton()
	return Widget.Box {
		class_name = "wifi-button",
		hexpand = true,
		Widget.Button {
			class_name = "toggle-button",
			Widget.Box {
				hexpand = true,
				Widget.Icon {
					icon = "network-wireless-symbolic"
				},
				Widget.Label {
					width_chars = 5,
					xalign = 0,
					justify = "FILL",
					halign = "START",
					label = "Wifi"
				}
			}
		},
		Widget.Button {
			class_name = "arrow-button",
			Widget.Box {
				Gtk.Separator {
					visible = true
				},
				Widget.Icon {
					icon = "go-down-symbolic"
				}
			}
		}
	}
end

local function BluetoothButton()
	return Widget.Box {
		class_name = "wifi-button",
		hexpand = true,
		Widget.Button {
			class_name = "toggle-button",
			Widget.Box {
				hexpand = true,
				Widget.Icon {
					icon = "bluetooth-symbolic"
				},
				Widget.Label {
					width_chars = 8,
					xalign = 0,
					justify = "FILL",
					halign = "START",
					label = "Bluetooth"
				}
			}
		},
		Widget.Button {
			class_name = "arrow-button",
			Widget.Box {
				Gtk.Separator {
					visible = true
				},
				Widget.Icon {
					icon = "go-down-symbolic"
				}
			}
		}
	}
end

return function()
	local Anchor = Astal.WindowAnchor
	return Widget.Window {
		name = "Control-panel",
		class_name = "control-panel",
		anchor = Anchor.BOTTOM + Anchor.RIGHT,
		exclusivity = "EXCLUSIVE",
		keymode = "ON_DEMAND",
		application = App,
		visible = false,
		on_key_press_event = function(self, event)
			if event.keyval == Gdk.KEY_Escape then
				self:hide()
			end
		end,
		Widget.Box {
			Widget.EventBox {
				width_request = 340,
				expand = true,
				on_click = hide
			},
			Widget.Box {
				hexpand = false,
				vertical = true,
				Widget.EventBox {
					on_click = hide,
					height_request = 1000
				},
				Widget.Box {
					class_name = "mainbox",
					width_request = 340,
					height_request = 600,
					vertical = true,
					spacing = 4,
					NotificationList(),
					Gtk.Separator {
						visible = true
					},
					AudioSliders(),
					Widget.Box {
						spacing = 4,
						hexpand = true,
						WifiButton(),
						BluetoothButton()
					}
				}
			}
		}
	}
end
