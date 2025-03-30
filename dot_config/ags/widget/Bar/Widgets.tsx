import { bind, Binding, GLib, Variable } from "astal";
import { Gtk } from "astal/gtk4";
import Hyprland from "gi://AstalHyprland";
import { exec, execAsync } from "astal/process";
import Battery from "gi://AstalBattery";

export function MenuButton() {
  return <button cssClasses={["logo"]} label=" " />;
}

export function ClockButton({ singleLine }: { singleLine: boolean }) {
  let dateFormat = "%a %b %d";
  let timeFormat = "%H:%M:%S";

  const time = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(timeFormat)!,
  );

  const date = Variable<string>("").poll(
    1000,
    () => GLib.DateTime.new_now_local().format(dateFormat)!,
  );

  return (
    <button
      cssClasses={["iconButton"]}
      onClicked={() => {
        // App.toggle_window(CalendarWindowName)
      }}
    >
      <box vertical={!singleLine} spacing={singleLine ? 4 : 0}>
        <label cssClasses={["date"]} label={date()} halign={Gtk.Align.END} />
        <label label={time()} halign={Gtk.Align.END} />
      </box>
    </button>
  );
}

function groupByProperty(array: Hyprland.Workspace[]): Hyprland.Workspace[][] {
  const map = new Map<Hyprland.Monitor, Hyprland.Workspace[]>();

  const filteredArray = array.filter(item => item.id !== -98);

  filteredArray.forEach((item) => {
    const key = item.monitor;
    if (key === null) {
      return;
    }
    if (!map.has(key)) {
      map.set(key, []);
    }
    map.get(key)!.push(item);
  });

  for (const [_, workspaces] of map.entries()) {
    workspaces.sort((a, b) => a.id - b.id);
  }

  return Array.from(map.values()).sort((a, b) => {
    if (a.length === 0) return 1;
    if (b.length === 0) return -1;
    return a[0].id - b[0].id;
  });
}

export function Workspaces({ vertical = false }: { vertical?: boolean }) {
  const hypr = Hyprland.get_default();

  const workspaceNames: Record<number, string> = {
    1: "zen",
    2: "term",
    3: "tg",
    4: "4",
    5: "5",
    6: "6",
    7: "7",
    8: "8",
    9: "9",
    10: "10",
  };

  return (
    <box vertical={vertical} spacing={8} cssClasses={["workspaces"]}>
      {bind(hypr, "workspaces").as((workspaces) => {
        const groupedWorkspaces = groupByProperty(workspaces);
        return groupedWorkspaces.map((workspaceGroup, _index) => (
          <box vertical={vertical} spacing={4} cssClasses={["workspace-group"]}>
            {workspaceGroup.map((workspace) => {
              return bind(workspace.monitor, "activeWorkspace").as(
                (activeWorkspace) => {
                  const isActive = activeWorkspace.id === workspace.id;
                  const workspaceName =
                    workspaceNames[workspace.id] || `${workspace.id}`;

                  return (
                    <button
                      label={workspaceName}
                      // tooltipText={workspaceName}
                      cssClasses={["workspace-btn", isActive ? "active" : ""]}
                      onClicked={() => {
                        hypr.dispatch("workspace", `${workspace.id}`);
                      }}
                    />
                  );
                },
              );
            })}
          </box>
        ));
      })}
    </box>
  );
}

export function SweepBattery() {
  const battery = Variable<string>("").poll(1000 * 30, () =>
    exec(["/home/muratoffalex/scripts/sweep_battery_level"]),
  );
  return <label cssClasses={["keyboard-battery"]} label={battery()} />;
}

export function MaterialIcon({
  icon,
  size = "norm",
}: {
  icon: string | Binding<string>;
  size: string;
}) {
  return <label cssClasses={["icon-material", `txt-${size}`]} label={icon} />;
}

export function NotificationsButton() {
  const hasDnd = Variable<boolean>(false).poll(1000, async () => {
    try {
      const result = await execAsync(["swaync-client", "-D"]);
      return result === "true";
    } catch (error) {
      console.error("Failed to check DND status:", error);
      return false;
    }
  });

  const hasNotifications = Variable<number>(0).poll(1000, async () => {
    try {
      const result = await execAsync(["swaync-client", "-c"]);
      const count = parseInt(result.trim(), 10);
      return count;
    } catch (error) {
      console.error("Failed to check notification count:", error);
      return 0;
    }
  });

  const getIcon = Variable<string>("").poll(1000, () => {
    if (hasDnd().get()) {
      return hasNotifications().get() > 0 ? `bedtime` : "bedtime";
    } else {
      return hasNotifications().get() > 0
        ? `notifications`
        : "notifications_off";
    }
  });

  const handleClick = () => {
    execAsync("swaync-client -t -sw").catch((error) => {
      console.error("Failed to toggle notification center:", error);
    });
  };

  // const handleRightClick = () => {
  //   execAsync("swaync-client -d -sw").catch((error) => {
  //     console.error("Failed to toggle DND mode:", error);
  //   });
  // };

  return (
    <button
      cssClasses={["notification-btn", hasDnd().get() ? "dnd" : ""]}
      onClicked={handleClick}
      tooltipText="Уведомления"
    >
      <box
        spacing={hasNotifications().get() > 0 ? 4 : 0}
        halign={Gtk.Align.CENTER}
      >
        <MaterialIcon icon={getIcon()} size="large" />
        {hasNotifications().as((count) =>
          count > 0 ? (
            <label label={`${count}`} cssClasses={["txt-smallie"]} />
          ) : (
            ""
          ),
        )}
      </box>
    </button>
  );
}

export function BatteryWidget() {
  const battery = Battery.get_default();

  // Определяем иконки для разных уровней заряда
  const getBatteryIcon = () => {
    const percentage = battery.percentage * 100;
    const state = battery.get_state();

    if (
      state === Battery.State.CHARGING ||
      state === Battery.State.PENDING_CHARGE
    ) {
      return "power";
    } else if (state === Battery.State.FULLY_CHARGED) {
      return "battery_full_alt";
    } else {
      // Выбираем иконку в зависимости от процента заряда
      if (percentage <= 10) return "battery_very_low";
      if (percentage <= 25) return "battery_low";
      if (percentage <= 50) return "battery_horiz_050";
      if (percentage <= 75) return "battery_horiz_075";
      if (percentage <= 100) return "battery_full_alt";
      return "battery_unknown";
    }
  };

  // Определяем CSS класс в зависимости от уровня заряда
  const getBatteryClass = () => {
    const percentage = battery.percentage * 100;
    const state = battery.state;

    if (state === Battery.State.CHARGING) {
      return "charging";
    } else if (percentage <= 15) {
      return "critical";
    } else if (percentage <= 30) {
      return "warning";
    } else {
      return "normal";
    }
  };

  // Формат текста для батареи
  const getBatteryText = () => {
    const percentage = battery.percentage * 100;
    const state = battery.get_state();
    print(state);

    if (state === Battery.State.CHARGING) {
      return `${percentage}%`;
    } else if (state === Battery.State.FULLY_CHARGED) {
      return `${percentage}%`;
    } else {
      return `${percentage}%`;
    }
  };

  return (
    <button
      cssClasses={["battery", getBatteryClass()]}
      tooltipText={`Батарея: ${battery.percentage}%, Состояние: ${battery.state}`}
      visible={battery.isBattery}
    >
      <box>
        <MaterialIcon icon={getBatteryIcon()} size="hugeass" />
        <label>{getBatteryText()}</label>
      </box>
    </button>
  );
}
