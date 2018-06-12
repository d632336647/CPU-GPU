import QtQuick 2.7
import QtGraphicalEffects 1.0
import "Styles.js" as TechDark
//六边形形框

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
    property string text: "六边形控件"
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
            ctx.moveTo(0.17*width+iw, iw)
            ctx.lineTo(0.83*width-iw, iw)
            ctx.lineTo(width-iw, 0.5*height)
            ctx.lineTo(0.83*width-iw, height-iw)
            ctx.lineTo(0.17*width+iw, height-iw)
            ctx.lineTo(iw, 0.5*height)
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
        font.pixelSize: parent.height * 0.35
        font.family: TechDark.fontFamily
        //font.family: "themify"
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
            PropertyChanges { target: root; opacity: 0}
            onCompleted:{
                    if(readyQuit)
                    {
                        Qt.quit()
                    }
            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: root; opacity: 1}
            onCompleted: {

            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "opacity"; duration: 1500; easing.type: Easing.InElastic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "opacity"; duration: 1500; easing.type: Easing.InBounce }
         }
    ]


    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}
