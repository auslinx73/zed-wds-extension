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

Example:

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

# План финализации

Сейчас надо сделать три вещи:

1. привести в порядок `zed-wds-extension`
2. убрать мусор из `tree-sitter-wds`
3. закоммитить оба репозитория уже чисто

## 1) Привести в порядок `zed-wds-extension`

Сначала сохрани `README.md` и текущий рабочий `languages/wds/highlights.scm`.

Потом проверь статус:

```powershell
cd E:\GitHub\zed-wds-extension && git status
```

Если всё выглядит нормально, коммитим:

```powershell
cd E:\GitHub\zed-wds-extension && git add README.md extension.toml languages/wds/highlights.scm languages/wds/config.toml languages/wds/indents.scm languages/wds/brackets.scm && git commit -m "Update README and improve WDS highlighting" && git push
```

Если часть файлов не менялась, Git просто возьмёт только изменённые.

## 2) Почистить `tree-sitter-wds`

Туда случайно попали служебные файлы:

- `grammar.js.bak`
- `parser.exp`
- `parser.lib`
- `parser.obj`

Их надо убрать из репозитория и добавить в `.gitignore`.

### Создать или обновить `.gitignore`

Если файла `.gitignore` там ещё нет, создай такой:

```gitignore
node_modules/
build/
*.obj
*.lib
*.exp
*.bak
```

### Удалить мусор из Git и закоммитить

```powershell
cd E:\GitHub\tree-sitter-wds && git rm --cached grammar.js.bak parser.exp parser.lib parser.obj && git add .gitignore grammar.js queries/highlights.scm src/grammar.json src/node-types.json src/parser.c test/corpus/basic.txt && git commit -m "Clean repository and finalize WDS grammar" && git push
```

Если Git скажет, что какого-то файла уже нет — это не страшно, тогда просто уберёшь его из команды.

## 3) Обновить commit в `zed-wds-extension` ещё раз

После нового коммита в `tree-sitter-wds` будет новый hash, и его надо снова подставить в `extension.toml` расширения.

Сделай так:

```powershell
$commit = (git -C E:\GitHub\tree-sitter-wds rev-parse HEAD).Trim() && ((Get-Content E:\GitHub\zed-wds-extension\extension.toml -Raw) -replace '(?m)^commit = .*$', ('commit = "' + $commit + '"')) | Set-Content E:\GitHub\zed-wds-extension\extension.toml -Encoding UTF8 && Get-Content E:\GitHub\zed-wds-extension\extension.toml | Select-String '^commit ='
```

Потом закоммить это изменение в `zed-wds-extension`:

```powershell
cd E:\GitHub\zed-wds-extension && git add extension.toml && git commit -m "Update pinned tree-sitter-wds revision" && git push
```

## 4) Финальная проверка

После этого:

- в Zed нажми **Rebuild**
- открой `.wds`
- проверь:
  - `var`
  - `If / ElseIf / Else`
  - `Switch / Case`
  - строки
  - комментарии
  - функции
  - методы через точку

## 5) Что улучшать потом

Когда всё закоммичено и стабильно работает, следующий спокойный этап:

- аккуратно расширить подсветку built-in функций `WD...`, `Tcp...`, `Udp...`
- добавить ещё тестов в `test/corpus/basic.txt`
- убрать warning про `unnecessary conflicts` в grammar
- потом уже заняться более умной подсветкой `Case Else`, `Math.*`, data-type methods
