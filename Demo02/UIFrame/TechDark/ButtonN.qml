import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as FlatDark

Item {
    id:root
    width: 300
    height: 300

    signal clicked()

    property color  bgColor: "#1A1A1C"
    property color  textColor: FlatDark.ButtonFontColor
    property int    padding: 4
    property int    fontSize:FlatDark.mainFontSize
    property string text: ""

    Rectangle {
        id: background
        anchors.fill: parent
        color: bgColor
    }

    RectangularGlow {
        id: effect
        anchors.fill: rect
        glowRadius: 0
        spread: 0.3
        color: "white"
        cornerRadius: rect.radius + glowRadius
    }

    Rectangle {
        id: rect
        color: "#404244"
        anchors.top: parent.top
        anchors.topMargin: padding
        anchors.left: parent.left
        anchors.leftMargin: padding
        anchors.right: parent.right
        anchors.rightMargin: padding
        anchors.bottom: parent.bottom
        anchors.bottomMargin: padding
        border.color:"#404244"
    }
    Text {
        id: btnText
        anchors.centerIn: parent
        color:textColor
        text: root.text
        font.pixelSize: root.fontSize
        font.family: FlatDark.fontFamily
    }
    MouseArea{
        id: btnMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            root.clicked()
        }
        onPressed: {
            //rect.border.color = "white"
            effect.glowRadius = 6
            //rect.color = "black"
        }
        onReleased:
        {
            effect.glowRadius = 0
            rect.border.color = "#404244"
            //rect.color = "#535456"

        }
        onEntered:
        {
            rect.border.color = "white"
            //pressedAnim.start()
        }
        onExited:
        {
            rect.border.color = "#404244"
            //releasedAnim.start()
        }
        PropertyAnimation {
            id: pressedAnim;
            target: effect;
            property: "glowRadius";
            to: 6;
            duration: 100
        }
        PropertyAnimation {
            id: releasedAnim;
            target: effect;
            property: "glowRadius";
            to: 0;
            duration: 100
        }
    }
}
