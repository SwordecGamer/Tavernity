import QtQuick 2.15
import QtQuick.Controls 2.15

Item {
    id: root
    anchors.fill: parent
    property var host

    Column {
        anchors.centerIn: parent
        spacing: 12

        Text { text: "Welcome Home!"; font.pixelSize: 26 }

        Button {
            text: "Log out"
            onClicked: root.host.currentPage = "pages/Login.qml"
        }
    }
}
