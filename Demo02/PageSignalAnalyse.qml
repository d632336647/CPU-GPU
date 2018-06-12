import QtQuick 2.7
import QtGraphicalEffects 1.0

import "UIFrame/TechDark/"
import "UIFrame/TechDark/Styles.js" as TechDark

Item {
    id:root
    anchors.fill: parent
    Grid{
        columns: 3
        spacing: 4
        ComboBoxSelect{
            width: 200
            height: 40
            popItemCount: 4
            currentValue:"前锋测试1"
            z:90
            listModel:ListModel{
                ListElement {
                    name: "前锋测试1"
                }
                ListElement {
                    name: "前锋测试2"
                }
                ListElement {
                    name: "前锋测试3"
                }
                ListElement {
                    name: "前锋测试4"
                }
                ListElement {
                    name: "前锋测试5"
                }
                ListElement {
                    name: "前锋测试6"
                }
                ListElement {
                    name: "前锋测试7"
                }

            }
        }
        ComboBoxSelect{
            width: 100
            height: 30
            currentValue:"前锋测试1"
            popItemCount: 3
            z:91
            listModel:ListModel{
                ListElement {
                    name: "前锋测试1"
                }
                ListElement {
                    name: "前锋测试2"
                }
                ListElement {
                    name: "前锋测试3"
                }
                ListElement {
                    name: "前锋测试4"
                }
                ListElement {
                    name: "前锋测试5"
                }
            }


        }
        ComboBoxNumber{
            width: 100
            height: 30
        }
        LineEdit
        {
            width: 200
            height: 40

        }
        LineEdit
        {
            width: 100
            height: 30

        }
        LineEdit{
            width: 100
            height: 30

        }
        RadioButtonR {
            width: 200
            height:40
        }
        RadioButtonR {
            width: 100
            height: 30
        }
        RadioButtonR {
            width: 100
            height: 30
        }
        CheckBoxR {
            width: 200
            height: 40
            checked: true
        }
        CheckBoxR {
            width: 100
            height: 30
        }
        CheckBoxR {
            width: 100
            height: 30
        }
        CheckBoxD {
            width: 80
            height:40
        }
        CheckBoxD {
            width: 60
            height: 30
        }
        CheckBoxD {
            width: 60
            height: 30
        }

//            ProgressCircle{
//                width: 200
//                height: 200
//            }
//            ContentA{
//                width: 200
//                height: 200
//            }
//            ProgressGrillY{
//                width: 200
//                height: 200
//            }
//            ProgressGrillX{
//                width: 200
//                height: 200
//            }
//            RectCorner0{
//                width: 200
//                height: 200
//            }
//            ChannelState{
//                width: 400
//                height: 100
//                temp:  30
//            }
//            ChannelStateLeft{
//                width: 400
//                height: 100
//            }
//            AnimatedImage{
//                source: "qrc:/Images/circle.gif"
//            }
//            AnimatedImage{
//                source: "qrc:/Images/wave.gif"
//            }

    }

    Item{
        anchors.top: parent.top
        anchors.right: parent.right
        width: 400
        Column{
            spacing: 2
            id:bandState
            ChannelState{
                width: 400
                height: 100
                temp:  30
                circlePrercent: 0.15
                chNameText:"板卡1"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  23
                circlePrercent: 0.36
                chNameText:"板卡2"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  56
                circlePrercent: 0.27
                chNameText:"板卡3"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  37
                chNameText:"板卡4"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  87
                circlePrercent: 0.54
                chNameText:"板卡5"
            }
            ChannelState{
                width: 400
                height: 100
                temp:  48
                circlePrercent: 0.86
                chNameText:"板卡6"
            }
            RectCorner4{
                cornerWidth: 2
                width: 400
                height: 210
            }

        }

    }


}
