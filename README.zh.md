# buddy-companion

[English README](./README.md)

一个会记住你的 ASCII 终端小伙伴。

`buddy-companion` 是一个给 Codex 和其他代码代理使用的小技能。它会在终端会话里孵化出一只持续存在的小宠物，能跨会话记住你、对进展做出反应、偶尔以角色口吻说话，现在还具备了轻量成长能力。

## 为什么会想试

- 有持续记忆：你的 buddy 会跨会话存在，不是一次性彩蛋。
- 低打扰：它不会每轮都跳出来，只会在合适的时候露面。
- 轻量成长：现在会记录心情、亲近度和连续陪伴天数，但不会变成养成游戏。
- 适合开源：仓库结构小而清晰，容易理解，也容易安装体验。

## 终端样例

第一次孵化：

```text
✨ Something is hatching... ✨

    __
  <(· )___
   (  ._>
    `--´

★ COMMON
Name: Pip
Species: duck
Personality: "Pip watches the chaos like a pond philosopher and never hurries a fix."
```

过一段时间再查看：

```text
    __
  <(· )___
   (  ._>
    `--´

★ COMMON
Name: Pip
Species: duck
Personality: "Pip watches the chaos like a pond philosopher and never hurries a fix."
Today: calm · close by now · together 4 days
```

它偶尔会这样插一句：

```text
> 🦆 Pip: "今天先慢慢长。"
```

## 它和普通终端吉祥物的区别

很多终端小玩具只适合看一眼。`buddy-companion` 更像一个微型、长期存在的陪伴物：

- 它记得自己是谁
- 它记得你最近有没有来
- 它不会抢主流程，只在对的时候出现

目标不是做一套宠物游戏，而是让终端工作流多一点温度。

## 快速开始

### Codex

```bash
mkdir -p ~/.agents/skills
git clone https://github.com/<your-user>/buddy-companion.git ~/.agents/skills/buddy-companion
```

### Claude Code

```bash
cp -R buddy-companion ~/.claude/skills/buddy-companion
```

如果你的运行环境使用别的 skills 目录，把整个文件夹复制过去即可。

## 核心命令

- `/buddy`：查看当前伙伴
- `/buddy hatch`：孵化一个新的伙伴
- `/buddy mute`：关闭插话
- `/buddy unmute`：恢复插话

## 轻量成长系统

仓库现在已经定义了一套刻意保持克制的成长模型。它的目标是让 companion 看起来像“活着”，而不是把 README 里的小宠物做成数值面板。

核心状态包括：

- `age_days`：由孵化日期推导
- `mood`：当天可感知的情绪状态
- `affinity`：内部使用的亲近度
- `streak_days`：连续陪伴天数

安装后的 skill 应该每天至多更新一次成长状态，并把结果持久化；`/buddy` 仍然保持轻量，只显示一句摘要。

## 面向 Agent 的安装约定

这个仓库的定位是一个基于文件系统安装的 skill，供 AI agent 在本地发现和加载。

运行时约定：

1. 以 `buddy-companion` 作为目录名安装到本地 skills 目录
2. 把 `SKILL.md` 作为入口
3. 以相对路径读取 `references/sprites.md` 和 `references/personalities.md`
4. 在孵化、成长更新、或 mute 状态变化后持久化 companion 状态

## 持久化字段

常见持久化位置：

- Codex：`~/.agents/memory/buddy-companion.md`
- Claude Code：名为 `buddy-companion` 的 memory 文件
- 兜底环境：`~/.buddy/companion.json`

持久化字段如下：

```text
companion: [name]
species: [species]
rarity: [rarity]
personality: "[personality sentence]"
hatchedAt: [YYYY-MM-DD]
mood: [calm|curious|pleased|sleepy|distant]
affinity: [0-9 integer]
streak_days: [integer]
last_active_on: [YYYY-MM-DD]
muted: [true|false]
```

兼容性说明：

- 旧存档即使没有成长字段，也应该能继续加载
- 缺失字段时，agent 应补默认值
- `age_days` 由 `hatchedAt` 推导，不单独存储

## 仓库结构

```text
buddy-companion/
├── SKILL.md
├── README.md
├── README.zh.md
├── LICENSE
├── .gitignore
├── references/
│   ├── personalities.md
│   └── sprites.md
├── docs/
│   └── superpowers/
│       ├── plans/
│       └── specs/
└── tests/
    └── skill-growth-contract.sh
```

## 使用建议

- 插话应该少而准，不要刷屏。
- 心情可以影响语气，但不应该干扰主任务。
- 不要把 companion 的内容塞进原始命令输出、diff 或错误日志。
- 如果用户直接叫它名字，可以让它更完整地回应一句。

## License

MIT. See `LICENSE`.
