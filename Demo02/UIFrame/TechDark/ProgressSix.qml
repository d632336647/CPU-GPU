import QtQuick 2.7
import QtGraphicalEffects 1.0

Item {
    id:root
    state: "HIDE"
    clip: true
    property color bgColor: "black"
    property color borderColor: "#A00AFFFC"
    property color shadowColor: "#1883D7"
    property int   iw: 18
    property int   circleWidth: 8
    property real  percent: 0.67
    property real  calibration: 5       //百分之五
    property bool  showGrow: true
    Text {
        id: showPercent
        text: parseInt(cricleMask.p * 100)
//        anchors.centerIn: parent
        font.family: "Phantasm"
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.verticalCenter: parent.verticalCenter
        anchors.verticalCenterOffset: -15
        anchors.horizontalCenterOffset: 7
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        color: "#c0c0c0"
        font.pixelSize:  parent.width * 0.3
        z:1
    }

    Item{
        id:pannel
        anchors.fill: parent
        rotation: -90
        Canvas{
            id:cricleBg
            anchors.fill: parent
            property real  r: width/2
            onPaint: {
                var ctx = getContext('2d')
                ctx.beginPath();
                ctx.lineWidth = circleWidth
                ctx.strokeStyle = "#443c30";
                ctx.arc(width/2, height/2,  r-iw-iw,  0, 2*Math.PI);
                //ctx.fill();  //填充
                ctx.stroke()
            }
        }
        Canvas{
            id:cricleMask
            anchors.fill: parent
            property real  r: width/2
            property real  d: 0
            property real  p: d / (2*Math.PI)
            onPaint: {
                var ctx = getContext('2d')
                //ctx.save();
                ctx.clearRect(0, 0, cricleMask.width, cricleMask.height);

                var dn = p*100            //0.65 --- 65
                var ti = 0
                var calib = calibration/10      //5 ---0.5

                for(var i=0; i <= dn/10 ; i=i+calib)
                {
                    ctx.beginPath();
                    ctx.lineWidth = circleWidth+18
                    ctx.strokeStyle = shadowColor
                    ctx.arc(width/2, height/2,  r-iw-iw,  (ti/10.0)*2*Math.PI , (i/10.0)*2*Math.PI);
                    ctx.stroke()
                    ti = i+0.1
                }
                if(dn >(percent*100 - (percent*100)%calibration)+1)
                {
                dn = dn%calibration         //65 % 5
                ctx.beginPath();
                ctx.lineWidth = circleWidth+18
                ctx.strokeStyle = "red"
                ctx.arc(width/2, height/2,  r-iw-iw,  (ti/10.0)*2*Math.PI , d/*(ti+dn/10.0)*2*Math.PI*/);
                ctx.stroke()
                }
            }
            onDChanged:
            {
                requestPaint()
            }
        }


        Glow {
            id:lineGrow
            anchors.fill: cricleMask
            cached: true
            fast: true
            radius: 8
            samples: 12
            color: shadowColor
            source: cricleMask
            spread: 0.2
            opacity: 0.8
            visible: showGrow


        }

        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: iw - circleWidth
            color: "#00000000"
            Canvas{
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext('2d')
                    ctx.beginPath();
                    ctx.lineWidth = 1.5
                    ctx.strokeStyle = shadowColor;
                    ctx.fillStyle = shadowColor
                    ctx.moveTo(width ,  0);
                    ctx.lineTo(width-0.86*height, 0.5*height);//0.86 = 1.72 / 2
                    ctx.lineTo(width, height);
                    ctx.closePath();
                    ctx.fill();  //填充
                    ctx.stroke()
                }
            }
//            transform: Rotation {origin.x: 0; origin.y:0
//                axis{x: 0; y: 1; z: 0}
//                angle: 65
//            }
        }


        Rectangle{
            anchors.centerIn: parent
            width: parent.width
            height: iw - circleWidth
            color: "#00000000"
            rotation:  cricleMask.p * 360
            Canvas{
                id:arrow
                anchors.fill: parent
                onPaint: {
                    var ctx = getContext('2d')
                    ctx.beginPath();
                    ctx.lineWidth = 1.5
                    ctx.strokeStyle = shadowColor;
                    ctx.fillStyle = shadowColor
                    ctx.moveTo(width ,  0);
                    ctx.lineTo(width-0.86*height, 0.5*height);
                    ctx.lineTo(width, height);
                    ctx.closePath();
                    ctx.fill();  //填充
                    ctx.stroke()
                }
            }
//            transform: Rotation {origin.x: 0; origin.y:0
//                axis{x: 0; y: 1; z: 0}
//                angle: 65
//            }
        }
        transform: Rotation {origin.x: 0; origin.y:parent.height/2
            axis{x: 1; y: 0; z: 0}
            angle: -65
        }
    }

    //过渡动画
    states: [
        State {
            name: "HIDE"
            PropertyChanges { target: cricleMask; d: 0}
            PropertyChanges { target: root; opacity: 0}
            onCompleted:{
                //root.visible = false
            }
        },
        State {
            name: "SHOW"
            PropertyChanges { target: cricleMask; d: (2*Math.PI) * percent}
            PropertyChanges { target: root; opacity: 1}
            onCompleted: {
            }
        }
    ]

    transitions: [
         Transition {
             from: "SHOW"
             to: "HIDE"
             PropertyAnimation { properties: "d,opacity"; duration: 1500; easing.type: Easing.OutCubic }
         },
         Transition {
             from: "HIDE"
             to: "SHOW"
             PropertyAnimation { properties: "d,opacity"; duration: 1500; easing.type: Easing.OutCubic }
         }
    ]

    onStateChanged:
    {
        //pannel.state = state
    }


    Component.onCompleted:
    {
//        root.state = "SHOW"

    }
//    transform: Rotation {origin.x: 100; origin.y: 100
//        axis{x: 1; y: 0; z: 0}
//        angle: 75
//    }
}
