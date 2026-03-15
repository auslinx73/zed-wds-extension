# WDS — Widget Designer Script for Zed

Syntax highlighting and language support for **Widget Designer Script (`.wds`)** in [Zed](https://zed.dev).

Widget Designer Script is used in **Widget Designer** (Christie Pandoras Box) to build interactive control panels, automate devices over TCP/UDP/ArtNet/DMX, and create custom show-control interfaces.

## Supported syntax

| Element | Examples |
|---|---|
| Variables | `var name = value` |
| Types | String, Double, Integer, Boolean, Date, List, Color, JSON |
| Conditions | `If` / `ElseIf` / `Else` |
| Switch | `Switch` / `Case` / `Case Else` |
| For Loop | `For i = 1 to 10 Step 2 { }` |
| ForEach | `ForEach item in list { }` |
| Control | `return`, `break`, `exit` |
| Logic | `AND`, `OR` (also `&&`, `\|\|`) |
| Functions | `TcpStart(id)`, `WDWait(0.5)`, `DebugMessage(x)` |
| Methods | `obj.Method`, `"text".Trim`, `list.Count` |
| Math | `Math.Floor(x)`, `Math.Random(0,100)`, `Math.Pi` |
| Widgets | `Fader1.Value`, `Label1.Text`, `ListView1.GetCell(1,i)` |
| Devices | `Tcp_Server1.LastMessageReceived`, `Udp_Client1` |
| Arrays | `list[0]`, `nested[2][1]` |
| Strings | `"double quotes"`, `'single quotes'` |
| Comments | `// single line`, `/* multi line */` |
| Operators | `+` `-` `*` `/` `^` `=` `==` `!=` `<` `>` `>=` `<=` |
| Compound | `+=` `-=` `*=` `/=` |

## Features

- Syntax highlighting: keywords, strings, numbers, comments, variables, functions, methods, operators, built-in WD commands, Math object, widget/device types
- Code folding for `If`, `Switch`, `For`, `ForEach` blocks
- Auto-closing brackets `{}`, `()`, `[]` and quotes `""`, `''`
- Auto indentation inside blocks

---

# Quick Install

## Windows

#### 1. Clone the extension

```powershell
D:
cd \
mkdir GitHub
cd GitHub
git clone https://github.com/auslinx73/zed-wds-extension.git
```

#### 2. Open Zed

#### 3. Press `Ctrl+Shift+P`, type:

```
install dev extension
```

#### 4. Select folder:

```
D:\GitHub\zed-wds-extension
```

#### 5. Open any `.wds` file — done!

---

## macOS

#### 1. Clone the extension

Open Terminal:

```bash
mkdir -p ~/GitHub
cd ~/GitHub
git clone https://github.com/auslinx73/zed-wds-extension.git
```

#### 2. Open Zed

#### 3. Press `Cmd+Shift+P`, type:

```
install dev extension
```

#### 4. Select folder:

```
~/GitHub/zed-wds-extension
```

#### 5. Open any `.wds` file — done!

---

## Linux

#### 1. Clone the extension

```bash
mkdir -p ~/GitHub
cd ~/GitHub
git clone https://github.com/auslinx73/zed-wds-extension.git
```

#### 2. Open Zed

#### 3. Press `Ctrl+Shift+P`, type:

```
install dev extension
```

#### 4. Select folder:

```
~/GitHub/zed-wds-extension
```

#### 5. Open any `.wds` file — done!

---

# Updating

Pull the latest version and rebuild:

**Windows:**
```powershell
cd D:\GitHub\zed-wds-extension
git pull
```

**macOS / Linux:**
```bash
cd ~/GitHub/zed-wds-extension
git pull
```

Then in Zed: `Ctrl+Shift+P` (or `Cmd+Shift+P`) → `extensions` → find **Widget Designer Script** → click **Rebuild**.

---

# Architecture

This repository contains the **Zed extension** only. The **Tree-sitter grammar** lives separately:

```
https://github.com/auslinx73/tree-sitter-wds
```

Zed loads the grammar automatically from the `repository` and `rev` fields in `extension.toml`. To **use** the extension you only need this repo. To **develop the grammar** you also need `tree-sitter-wds`.

### If you update the grammar

1. Commit and push changes in `tree-sitter-wds`
2. Copy the new commit hash
3. Update `commit = "..."` in `extension.toml`
4. Rebuild or reinstall the dev extension in Zed

## Project structure

```
zed-wds-extension/
├── extension.toml              # Extension manifest
├── README.md
├── grammars/                   # Grammar reference
└── languages/
    └── wds/
        ├── config.toml         # Language configuration
        ├── highlights.scm      # Syntax highlighting rules
        ├── indents.scm         # Auto-indent rules
        └── brackets.scm        # Bracket matching
```

## Example

```wds
// Projector power check
TcpStart(pj_tcp_id)
WDWait(0.5)
TcpSend(pj_tcp_id, "%1POWR ?[CR]")

var response = Tcp_Server1.LastMessageReceived.Trim

Switch response {
    Case "OK1"
        power_status = "on"
    Case "OK0"
        power_status = "off"
    Case Else
        power_status = "??"
}

If power_status == "on" {
    WDCustomScriptLabelColor(1, 0, 255, 0)
    Label1.Text = "Projector ON"
} ElseIf power_status == "off" {
    WDCustomScriptLabelColor(1, 255, 0, 0)
    Label1.Text = "Projector OFF"
} Else {
    WDCustomScriptLabelColor(1, 125, 125, 125)
    Label1.Text = "Status: " + power_status
}

For i = 1 to 10 {
    WDFaderValue(i, Math.Random(0, 255))
    WDWait(0.2)
}

var cities = ["Berlin", "Paris", "Tokyo"]
ForEach city in cities {
    DebugMessage(Now.Format("t") + " — " + city)
}
```

## Contributing

Found a WDS construct that parses incorrectly? Open an issue with a code sample.

## License

MIT
