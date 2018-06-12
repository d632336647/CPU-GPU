import QtQuick 2.0
import QtGraphicalEffects 1.0

Glow{

    property var rsource: rsource
    property real time: 2000
    id:rglow
    anchors.fill: rsource
    radius: 3
    samples: 7
    color: "#00f0ff"
    source: rsource
    spread: 0.5
    opacity: 1
    NumberAnimation on opacity {
        id:an1
        to:0.8
        duration: time
        running: true
        onStopped:
        {
            an2.start()
        }
    }
    NumberAnimation on opacity {
        id:an2
        to:0.2
        duration: time
        running: true
        onStopped:
        {
            an1.start()
        }
    }
}
