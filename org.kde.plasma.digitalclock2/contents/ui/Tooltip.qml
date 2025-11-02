/*
 *   SPDX-FileCopyrightText: 2015 Martin Klapetek <mklapetek@kde.org>
 *   SPDX-License-Identifier: LGPL-2.0-or-later
 */

pragma ComponentBehavior: Bound

import QtQuick
import QtQuick.Layouts
import org.kde.plasma.components as PlasmaComponents
import org.kde.plasma.plasmoid
import org.kde.kirigami as Kirigami
import org.kde.plasma.private.digitalclock

Item {
    id: toolTipContentItem

    // Adjust size to match CalendarView's typical dimensions
    implicitWidth: Kirigami.Units.gridUnit * 45
    implicitHeight: Kirigami.Units.gridUnit * 25

    Kirigami.Theme.colorSet: Kirigami.Theme.Window
    Kirigami.Theme.inherit: false

    // Accessibility properties for compact representation (unchanged)
    Accessible.name: i18nc("@info:tooltip %1 is a localized long date", "Today is %1", Qt.formatDate(root.currentDateTimeInSelectedTimeZone, Qt.locale(), Locale.LongFormat))
    Accessible.description: "Calendar view showing the current month and events"

    CalendarView {
        id: calendarView
        anchors.fill: parent

        // Pass necessary properties from root (PlasmoidItem)
        appletInterface: root
        today: root.currentDateTimeInSelectedTimeZone
        firstDayOfWeek: Plasmoid.configuration.firstDayOfWeek > -1
        ? Plasmoid.configuration.firstDayOfWeek
        : Qt.locale().firstDayOfWeek
        showWeekNumbers: Plasmoid.configuration.showWeekNumbers
        eventPluginsManager: PlasmaCalendar.EventPluginsManager {
            enabledPlugins: Plasmoid.configuration.enabledCalendarPlugins
        }
    }
}
