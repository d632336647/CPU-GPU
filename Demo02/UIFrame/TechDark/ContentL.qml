import QtQuick 2.7
import QtGraphicalEffects 1.0
//方形控件
Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color borderColor: "#A00AFFFC"
    property color shadowColor: "#0AFFFC"
    property int   iw: 12
    property bool  showGrow: true
    Canvas{
        id:line
        anchors.fill: parent
        property real percent : 1
        onPaint: {
            var ctx = getContext('2d')
            //ctx.save();
            ctx.clearRect(0, 0, line.width, line.height);

            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.strokeStyle = borderColor;
            ctx.moveTo(iw, iw)
            ctx.lineTo(iw + percent * (width-2*iw), iw)
            ctx.stroke()

            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.moveTo(width-iw, iw)
            ctx.lineTo(width-iw, iw + percent * (height-2*iw))
            ctx.stroke()

            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.moveTo(width-iw, height-iw)
            ctx.lineTo(iw + (1-percent)*(width - 2*iw), height-iw )
            ctx.stroke()

            ctx.beginPath();
            ctx.lineWidth = 1.5
            //ctx.lineJoin = "round"
            ctx.lineCap = "round"
            ctx.moveTo(iw, height-iw)
            ctx.lineTo(iw, iw + (1-percent)*(height - 2*iw))
            ctx.stroke()
        }
        onPercentChanged:
        {
            requestPaint()
        }
    }
    Glow {
        id:lineGrow
        anchors.fill: line
        cached: true
        fast: true
        radius: 10
        samples: 14
        color: shadowColor
        source: line
        spread: 0.6
        opacity: 0.8
        visible: showGrow
    }

    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: line; percent: 0}
            onCompleted:{

            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: line; percent: 1}
            onCompleted: {

            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "percent"; duration: 1500; easing.type: Easing.OutExpo }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "percent"; duration: 1500; easing.type: Easing.InExpo }//OutCubic
         }
    ]


    Component.onCompleted:
    {
        root.state = "SHOW"
    }

}
