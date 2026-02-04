import QtQuick 2.15
import QtQuick.Controls 2.15
import QtQuick.Layouts 1.15

ApplicationWindow {
    id: window
    visible: true
    width: 1000
    height: 650
    title: "Tavernity"

    property string token: ""
    property string currentPage: "pages/Login.qml"
    property string currentUser: ""

    function navigate(pageUrl) {
        currentPage = pageUrl
        navDrawer.close()
    }

    header: ToolBar {
        RowLayout {
            anchors.fill: parent
            spacing: 8

            ToolButton {
                text: "\u2630"
                visible: window.currentPage != "pages/Login.qml"
                onClicked: navDrawer.open()
            }
        }
    }

    Drawer {
        id: navDrawer
        edge: Qt.LeftEdge
        width: Math.min(320, window.width * 0.75)
        height: window.height

        ColumnLayout {
            anchors.fill: parent
            spacing: 0

            Rectangle {
                Layout.fillWidth: true
                height: 84
                color: "#1f1f1f"
                border.color: "#2b2b2b"

                Column {
                    anchors.fill: parent
                    anchors.margins: 14
                    spacing: 6
                    Text { text: currentUser; color: "white"; font.pixelSize: 20; font.bold: true }
                    ItemDelegate {
                        text: "My Account"
                        onClicked: window.navigate("pages/Account.qml")
                        enabled: window.currentPage !== "pages/Account.qml"
                    }
                }
            }

            ItemDelegate {
                Layout.fillWidth: true
                text: "Home"
                onClicked: window.navigate("pages/Home.qml")
                enabled: window.currentPage !== "pages/Home.qml"
            }
            ItemDelegate {
                Layout.fillWidth: true
                text: "Servers"
                onClicked: window.navigate("pages/Servers.qml")
                enabled: window.currentPage !== "pages/Servers.qml"
            }

            Item { Layout.fillHeight: true }

            ItemDelegate {
                Layout.fillWidth: true
                text: "Account"
                onClicked: window.navigate("pages/Account.qml")
                enabled: window.currentPage !== "pages/Account.qml"
            }
            ItemDelegate {
                Layout.fillWidth: true
                text: "Settings"
                onClicked: window.navigate("pages/Settings.qml")
                enabled: window.currentPage !== "pages/Settings.qml"
            }

            Rectangle { Layout.fillWidth: true; height: 1; color: "#2b2b2b" }

            ItemDelegate {
                Layout.fillWidth: true
                text: "Logout"
                onClicked: {
                    window.token = ""
                    window.navigate("pages/Login.qml")
                }
            }
        }
    }


    Loader {
        id: pageLoader
        anchors.fill: parent
        source: window.currentPage

        onLoaded: {
            if (item) {
                item.host = window
            }
        }
    }
}