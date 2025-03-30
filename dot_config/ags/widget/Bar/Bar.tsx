import { App, Astal, Gtk, Gdk } from "astal/gtk4";
import Bluetooth from "gi://AstalBluetooth";
import {
  BatteryWidget,
  ClockButton,
  MaterialIcon,
  MenuButton,
  NotificationsButton,
  SweepBattery,
  Workspaces,
} from "./Widgets";
import Tray from "gi://AstalTray";
import Battery from "gi://AstalBattery";

const bluetooth = Bluetooth.get_default();

for (const device of bluetooth.get_devices()) {
  print(device.name);
}

const tray = Tray.get_default();

for (const item of tray.get_items()) {
  print(item.title);
}

const battery = Battery.get_default();

print(battery.get_percentage());

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible
      cssClasses={["Bar"]}
      gdkmonitor={gdkmonitor}
      layer={Astal.Layer.TOP}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={App}
    >
      <centerbox cssName="centerbox">
        <box spacing={8}>
          <MenuButton />
          <Workspaces />
        </box>
        <box>
          {/* <menubutton hexpand halign={Gtk.Align.CENTER}> */}
          {/*   <label label={time()} /> */}
          {/*   <popover> */}
          {/*     <Gtk.Calendar /> */}
          {/*   </popover> */}
          {/* </menubutton> */}
        </box>
        <box spacing={12}>
          <MaterialIcon icon="keyboard" size="norm" />
          <SweepBattery />
          <BatteryWidget />
          <ClockButton singleLine={false} />
          <NotificationsButton />
        </box>
      </centerbox>
    </window>
  );
}
