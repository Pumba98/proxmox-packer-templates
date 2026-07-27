#!/usr/bin/env python3
"""Reads a windows VM's machine SID over WinRM.

Query and result are JSON on stdin/stdout.
"""

import json
import re
import sys

import winrm

PS = '(Get-LocalUser -Name "{}").SID.AccountDomainSid.Value'


def main():
    query = json.load(sys.stdin)

    session = winrm.Session(
        "http://{}:5985/wsman".format(query["host"]),
        auth=(query["user"], query["password"]),
        transport="basic",
        read_timeout_sec=60,
        operation_timeout_sec=50,
    )

    sid = ""
    try:
        result = session.run_ps(PS.format(query["user"]))
        if result.status_code == 0:
            match = re.search(r"S-1-5-21-[\d-]+", result.std_out.decode(errors="replace"))
            if match:
                sid = match.group(0)
    except Exception as exc:
        print(exc, file=sys.stderr)

    json.dump({"sid": sid}, sys.stdout)


if __name__ == "__main__":
    main()
