from __future__ import annotations

from typing import List, Dict

from PySide6.QtCore import QObject, Signal, Slot, Property

from services.server_store import ServerStore, ServerEntry


class ServerController(QObject):
    serversChanged = Signal()
    errorChanged = Signal()

    def __init__(self, store:ServerStore, parent=None):
        super().__init__(parent)
        self._store = store
        self._servers: List[ServerEntry] = self._store.load()
        self._error: str = ""

    def get_error(self) -> str:
        return self._error
    
    def set_error(self, value: str) -> None:
        if self._error == value:
            return
        self._error = value
        self.errorChanged.emit()

    error = Property(str, get_error, set_error, notify=errorChanged)

    def get_servers(self) -> List[Dict]:
        return [
            {
                "name": server.name,
                "address": server.address,
                "port": server.port,
                "notes": server.notes,
            }
            for server in self._servers
        ]
    
    servers = Property("QVariantList", get_servers, notify=serversChanged)

    @Slot()
    def reload(self) -> None:
        self._servers = self._store.load()
        self.serversChanged.emit()

    @Slot(str, str, int, str)
    def addServer(self, name: str, address: str, port: int, notes: str) -> None:
        self.error = ""

        name = (name or "").strip()
        address = (address or "").strip()
        port = int(port or 0)

        if not name:
            self.error = "Server name cannot be empty."
            return
        if not address:
            self.error = "Server address cannot be empty."
            return
        if port < 0 or port > 65535:
            self.error = "Port must be between 0 and 65535."
            return
        
        self._servers.append(ServerEntry(name=name, address=address, port=port, notes=notes))
        self._store.save(self._servers)
        self.serversChanged.emit()

    @Slot(int)
    def removeServer(self, index: int) -> None:
        self.error = ""
        if index < 0 or index >= len(self._servers):
            self.error = "Invalid server index."
            return
        self._servers.pop(index)
        self._store.save(self._servers)
        self.serversChanged.emit()