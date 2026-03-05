# WDS — Widget Designer Script для Zed

Подсветка синтаксиса и языковая поддержка **Widget Designer Script (.wds)** для редактора [Zed](https://zed.dev).

Widget Designer Script — скриптовый язык, используемый в Widget Designer для создания интерактивных панелей управления, автоматизации оборудования (проекторы, аудиосистемы, свет через TCP/UDP) и построения кастомных интерфейсов управления шоу.

## Возможности

- **Подсветка синтаксиса** — ключевые слова, строки, числа, комментарии, функции, операторы, переменные
- **Сворачивание кода** — блоки `If`/`ElseIf`/`Else`, `Switch`/`Case`
- **Автозакрытие** — скобки `{}`, `()`, `[]` и кавычки `""`
- **Автоотступы** — автоматические отступы внутри блоков

### Поддерживаемый синтаксис

| Элемент | Примеры |
|---|---|
| Переменные | `var name = value` |
| Условия | `If` / `ElseIf` / `Else` |
| Переключатель | `Switch` / `Case` / `Case Else` |
| Возврат | `return result` |
| Функции | `TcpStart(id)`, `WDWait(0.5)` |
| Методы | `obj.Method`, `list.Copy`, `str.Trim` |
| Массивы | `list[0]`, `parts[1]` |
| Математика | `Math.floor(x)`, `Math.Mod(x, y)` |
| Строки | `"hello"`, `"HH:MM"` |
| Комментарии | `// однострочный комментарий` |
| Операторы | `+` `-` `*` `/` `<` `>` `=` `==` `!=` `&&` `||` |

## Установка

### Вариант А — Dev Extension (рекомендуется)

1. **Склонируй репозиторий:**

   ```bash
   git clone https://github.com/auslinx73/zed-wds-extension.git
   ```

2. **Открой Zed** и нажми `Ctrl+Shift+P` (или `Cmd+Shift+P` на macOS)

3. **Набери** `install dev extension` и выбери эту команду

4. **Укажи папку** `zed-wds-extension`, которую только что склонировал

5. **Готово!** Открой любой `.wds` файл — Zed автоматически определит его как Widget Designer Script

### Вариант Б — Ручная установка

1. **Склонируй репозиторий** в папку расширений Zed:

   **Windows:**
   ```bash
   git clone https://github.com/auslinx73/zed-wds-extension.git "%LOCALAPPDATA%\Zed\extensions\installed\wds"
   ```

   **Linux:**
   ```bash
   git clone https://github.com/auslinx73/zed-wds-extension.git ~/.local/share/zed/extensions/installed/wds
   ```

   **macOS:**
   ```bash
   git clone https://github.com/auslinx73/zed-wds-extension.git ~/Library/Application\ Support/Zed/extensions/installed/wds
   ```

2. **Перезапусти Zed**

## Обновление

Чтобы обновить до последней версии:

```bash
cd путь/к/zed-wds-extension
git pull
```

Затем в Zed: `Ctrl+Shift+P` → `extensions` → найди «Widget Designer Script» → нажми **Rebuild**.

## Структура проекта

```
zed-wds-extension/
├── extension.toml              # Манифест расширения
└── languages/
    └── wds/
        ├── config.toml         # Конфигурация языка
        ├── highlights.scm      # Правила подсветки синтаксиса
        ├── indents.scm         # Правила автоотступов
        └── brackets.scm        # Парные скобки
```

Грамматика Tree-sitter хранится отдельно:
[auslinx73/tree-sitter-wds](https://github.com/auslinx73/tree-sitter-wds)

## Пример кода

```wds
// Проверка питания проектора
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

## Участие в разработке

Нашёл конструкцию WDS, которая парсится неправильно? Открой issue с примером кода — добавим в грамматику.

## Лицензия

MIT
