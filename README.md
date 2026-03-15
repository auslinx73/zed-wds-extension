# WDS — Widget Designer Script for Zed




Syntax highlighting and language support for **Widget Designer Script (`.wds`)** in [Zed](https://zed.dev).

Widget Designer Script is used in **Widget Designer** to build interactive control panels, automate devices over TCP/UDP, and create custom control interfaces for AV and show-control workflows.

## Features_

- Syntax highlighting for:
  - keywords
  - strings
  - numbers
  - comments
  - variables
  - function calls
  - member access
  - operators
- Code folding for block structures
- Auto-closing pairs for brackets and quotes
- Auto indentation inside blocks

## Supported syntax

| Element | Examples |
|---|---|
| Variables | `var name = value` |
| Conditions | `If` / `ElseIf` / `Else` |
| Switch | `Switch` / `Case` / `Case Else` |
| Return | `return result` |
| Functions | `TcpStart(id)`, `WDWait(0.5)` |
| Methods | `obj.Method`, `list.Copy`, `str.Trim` |
| Arrays | `list[0]`, `parts[1]` |
| Strings | `"hello"`, `"HH:MM"` |
| Comments | `// comment` |
| Operators | `+` `-` `*` `/` `<` `>` `=` `==` `!=` `&&` `||` |

# Installation

## Quick start from scratch (Windows)

This repository contains the **Zed extension** for Widget Designer Script.

The **Tree-sitter grammar source** lives in a separate repository:

`https://github.com/auslinx73/tree-sitter-wds`

Zed loads that grammar automatically from the `repository` and `rev` fields in `extension.toml`.
That means:

- to **use** the extension, you only need to clone **this** repository
- to **develop the grammar**, you should also clone `tree-sitter-wds`

Zed can install a local development extension through **Install Dev Extension**, and the grammar is resolved from the pinned repository/revision declared in the extension manifest.

### Option A — Install and use the extension

#### 1. Create a folder for your repositories

Example: Disk D

```powershell
D:
cd \
mkdir GitHub
cd GitHub
git clone https://github.com/auslinx73/zed-wds-extension.git
```




2. Open Zed

3. Run:

`Ctrl+Shift+P` → `install dev extension`

4. Select the folder:

```text
zed-wds-extension
```

5. Open any `.wds` file

### Option B — Manual install

Clone the repository into the Zed extensions folder.

**Windows**
```bash
git clone https://github.com/auslinx73/zed-wds-extension.git "%LOCALAPPDATA%\Zed\extensions\installed\wds"
```

**Linux**
```bash
git clone https://github.com/auslinx73/zed-wds-extension.git ~/.local/share/zed/extensions/installed/wds
```

**macOS**
# WDS для Zed — Быстрая установка на macOS

## 1. Склонируй расширение

Открой Terminal и выполни:

```bash
mkdir -p ~/GitHub
cd ~/GitHub
git clone https://github.com/auslinx73/zed-wds-extension.git
```

## 2. Установи в Zed

1. Открой **Zed**
2. Нажми `Cmd+Shift+P`
3. Набери `install dev extension`
4. Укажи папку `~/GitHub/zed-wds-extension`
5. Готово!

## 3. Проверка

Открой любой `.wds` файл — подсветка должна работать.



## 4. Обновление

```bash
cd ~/GitHub/zed-wds-extension
git pull
```

В Zed: `Cmd+Shift+P` → `reload extensions`

```bash
git clone https://github.com/auslinx73/zed-wds-extension.git ~/Library/Application\ Support/Zed/extensions/installed/wds
```

Then restart Zed.

## Updating

This extension uses a separate Tree-sitter grammar repository:

`https://github.com/auslinx73/tree-sitter-wds`

The grammar revision is pinned in `extension.toml`.

### If you update only the extension repo

For changes in:

- `languages/wds/highlights.scm`
- `languages/wds/indents.scm`
- `languages/wds/brackets.scm`
- `languages/wds/config.toml`
- `README.md`

just rebuild the extension in Zed.

### If you update the grammar repo

1. Commit and push changes in `tree-sitter-wds`
2. Copy the new commit hash
3. Update `commit = "..."` in `zed-wds-extension/extension.toml`
4. Rebuild or reinstall the dev extension in Zed

## Rebuild in Zed

Open:

`Ctrl+Shift+P` → `extensions`

Find **Widget Designer Script** and click **Rebuild**.

If rebuild fails after grammar changes, reinstall the dev extension from the `zed-wds-extension` folder.

## Project structure

```text
zed-wds-extension/
├── extension.toml
├── README.md
└── languages/
    └── wds/
        ├── config.toml
        ├── highlights.scm
        ├── indents.scm
        └── brackets.scm
```

Tree-sitter grammar is stored separately:

```text
tree-sitter-wds/
├── grammar.js
├── tree-sitter.json
├── queries/
│   └── highlights.scm
├── src/
└── test/
```

## Example

```wds
// Projector power check
TcpStart(pj_tcp_id)
WDWait(0.5)
TcpSend(pj_tcp_id, "%1POWR ?[CR]")

var response = OptomaTcpResponce.Trim

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
} ElseIf power_status == "off" {
    WDCustomScriptLabelColor(1, 255, 0, 0)
} Else {
    WDCustomScriptLabelColor(1, 125, 125, 125)
}
```

## Development notes

- The Zed extension and the Tree-sitter grammar live in separate repositories
- The grammar commit is pinned in `extension.toml`
- If Zed cannot compile the grammar, check:
  - the grammar commit in `extension.toml`
  - local changes inside `grammars/wds`
  - query files such as `highlights.scm`
- Query files must match actual node types from the grammar

## Contributing

If you find a WDS construct that parses incorrectly, open an issue with a minimal code sample.

## License

MIT

---





- аккуратно расширить подсветку built-in функций `WD...`, `Tcp...`, `Udp...`
- добавить ещё тестов в `test/corpus/basic.txt`
- убрать warning про `unnecessary conflicts` в grammar
- потом уже заняться более умной подсветкой `Case Else`, `Math.*`, data-type methods
