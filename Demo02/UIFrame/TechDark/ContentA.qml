import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as TechDark
//梯形框

Item {
    id:root
    state: "HIDE"
    clip: true
    property color  bgColor: "black"
    property color  borderColor: "#A00AFFFC"
    property color  shadowColor: "#0AFFFC"
    property int    iw: 14
    property bool   r2l : true
    property color  textColor: "#C0C0C0"
    property string text: "梯形控件"
    signal clicked()
    Canvas{
        id:mBox
        anchors.fill: parent
        onPaint: {
            var ctx = getContext('2d')
            //ctx.save();
            ctx.clearRect(0, 0, width, height);
            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = borderColor;
            ctx.moveTo(iw, iw)
            ctx.lineTo(width-iw, iw)
            ctx.lineTo(0.90*width-iw, height-iw)
            ctx.lineTo(0.10*width+iw, height-iw)
            ctx.closePath()
            ctx.stroke()
        }
    }
    Glow {
        id:lineGrow
        source: mBox
        anchors.fill: mBox
        cached: true
        fast: true
        radius: 10
        samples: 14
        color: shadowColor
        spread: 0.6
        opacity: 0.8
    }
    Text {
        id: btnText
        rotation: -root.rotation
        anchors.centerIn: parent
        color:textColor
        text: root.text
        font.pixelSize: parent.height * 0.3
        font.family: TechDark.fontFamily
    }

    Rectangle{
        id:mask
        x:0
        y:0
        width: parent.width
        height: parent.height
        color: bgColor
    }

    MouseArea{
        id: btnMouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        onClicked: {
            clickAnim.start()
            root.clicked()
        }
        onEntered:
        {
            root.borderColor ="#A0F95F46"
            root.shadowColor = "#F95F46"
            mBox.requestPaint()
            pressedAnim.start()
        }
        onExited:
        {
            root.borderColor ="#A00AFFFC"
            root.shadowColor = "#0AFFFC"
            mBox.requestPaint()
            releasedAnim.start()
        }
        PropertyAnimation {
            id: pressedAnim;
            target: lineGrow;
            property: "opacity";
            to: 0.4;
            duration: 300
        }
        PropertyAnimation {
            id: releasedAnim;
            target: lineGrow;
            property: "opacity";
            to: 0.8
            duration: 300
        }
        PropertyAnimation {
            id: clickAnim;
            target: lineGrow;
            property: "opacity";
            to: 1
            duration: 200
            onStopped: {
                pressedAnim.start()
            }
        }
    }


    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: mask; x: 0}
            onCompleted:{

            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: mask; x: r2l ? (- root.width) : (root.width)}
            onCompleted: {

            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "x"; duration: 1500; easing.type: Easing.OutCubic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "x"; duration: 1500; easing.type: Easing.OutCubic }
         }
    ]


    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}
