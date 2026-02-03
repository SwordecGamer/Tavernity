from __future__ import annotations

import json

from dataclasses import dataclass, asdict
from pathlib import Path
from typing import List, Optional

@dataclass
class ServerEntry:
    name: str
    address: str
    port: int = 0
    notes: str = ""

class ServerStore:
    def __init__(self, file_path: Optional[Path] = None):
        if file_path is None:
            base = Path(__file__).resolve().parents[1]
            file_path = base / "config" / "servers.json"

        self._file_path = file_path
        self._file_path.parent.mkdir(parents=True, exist_ok=True)

    @property
    def file_path(self) -> Path:
        return self._file_path
    
    def load(self) -> List[ServerEntry]:
        if not self._file_path.exists():
            return []
        try:
            raw = json.loads(self._file_path.read_text(encoding="utf-8"))
            if not isinstance(raw, list):
                return []
            entries: List[ServerEntry] = []
            for item in raw:
                if not isinstance(item, dict):
                    continue
                entries.append(
                    ServerEntry(
                        name=str(item.get("name", "")).strip(),
                        address=str(item.get("address", "")).strip(),
                        port=int(item.get("port", 0) or 0),
                        notes=str(item.get("notes", "") or ""),
                    )
                )
            
            return [e for e in entries if e.name and e.address]
        except Exception:
            return []
    
    def save(self, entries: List[ServerEntry]) -> None:
        data = [asdict(e) for e in entries]
        self._file_path.write_text(json.dumps(data, indent=2), encoding="utf-8")