import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent

    property var host

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text {
            text: "Register Page"
            font.pixelSize: 26
        }

        Button {
            text: "Back to Login"
            onClicked: {
                root.host.currentPage = "pages/Login.qml"
            }
        }
    }
}
