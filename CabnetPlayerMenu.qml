import QtQuick
import QtQuick.Controls

Menu {
    id: menuSelf

    background: Rectangle {
        implicitWidth: 200
        color: "#000000"
        border.color: "#8F8F8F"
        border.width: 1
        Rectangle {
            x: + 1
            y: -2
            height: 4
            width: menuSelf.parent.width - 2
            color: parent.color
        }
    }

    delegate: MenuItem {
        id: menu_item

        background: Rectangle {
            implicitWidth: 200
            implicitHeight: 20
            opacity: enabled ? 1 : 0.3
            color: menu_item.highlighted ? "#d81f60" : "transparent"
        }
    }

    // Rectangle {
    //     height: 5
    //     width: menuSelf.parent.width
    //     color: "#00FFFF"
    // }
}
