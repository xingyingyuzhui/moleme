# 摸了么 (Moleme)

一款专为"摸鱼打工人"设计的 iOS 摸鱼计时器应用，实时计算你摸鱼赚了多少钱！

![Platform](https://img.shields.io/badge/Platform-iOS%2017%2B-blue)
![Swift](https://img.shields.io/badge/Swift-5.9-orange)
![SwiftUI](https://img.shields.io/badge/SwiftUI-5.0-green)
![License](https://img.shields.io/badge/License-MIT-lightgrey)

## 功能特性

### 核心功能
- **实时收益计算** - 根据你的月薪、工作天数、每日工时精确计算每秒收入
- **后台计时** - 切换到后台也能继续计时，不错过每一分钱
- **数据持久化** - 使用 SwiftData 保存历史摸鱼记录
- **分享战绩** - 生成精美分享卡片，炫耀你的摸鱼成果

### 特色功能
- **老板键** - 双击屏幕瞬间切换到伪装界面，安全摸鱼
- **触感反馈** - 操作时提供触觉反馈，体验更佳
- **输入验证** - 自动校正不合理的设置值

## 截图预览

| 摸鱼计时 | 分享卡片 | 设置页面 |
|:---:|:---:|:---:|
| 💰 实时收益 | 📤 一键分享 | ⚙️ 个性配置 |

## 技术架构

```
moleme/
├── molemeApp.swift              # 应用入口，注入环境对象
├── ContentView.swift            # TabView 主容器
├── Models/
│   └── SlackingSession.swift    # SwiftData 数据模型
├── ViewModels/
│   └── SessionManager.swift     # 共享状态管理器 (ObservableObject)
├── Views/
│   ├── HomeView.swift           # 主页计时器
│   ├── ShareCardView.swift      # 分享卡片 & 容器
│   ├── SettingsView.swift       # 设置页面
│   └── BossKeyView.swift        # 老板键伪装界面
└── Utils/
    └── SalaryCalculator.swift   # 薪资计算逻辑
```

### 核心设计

| 组件 | 技术 | 说明 |
|------|------|------|
| 状态管理 | `@EnvironmentObject` | SessionManager 全局共享状态 |
| 数据持久化 | SwiftData | 保存历史摸鱼会话 |
| 后台处理 | ScenePhase | 监听应用状态变化，计算后台时间 |
| 定时器 | Combine Timer | 每秒更新收益 |

## 薪资计算公式

```
每秒收入 = 月薪 ÷ (每月工作天数 × 每日工时 × 3600)

示例：月薪 10000 元，每月 22 天，每天 8 小时
每秒收入 = 10000 ÷ (22 × 8 × 3600) = 0.0158 元/秒
```

## 快速开始

### 环境要求
- macOS 14.0+
- Xcode 15.0+
- iOS 17.0+ (模拟器或真机)

### 运行项目

```bash
# 克隆仓库
git clone https://github.com/xingyingyuzhui/moleme.git
cd moleme

# 打开 Xcode 项目
open moleme.xcodeproj

# 选择模拟器，点击运行 (⌘+R)
```

### 运行测试

```bash
xcodebuild test \
  -project moleme.xcodeproj \
  -scheme moleme \
  -destination 'platform=iOS Simulator,name=iPhone 17'
```

## 使用指南

1. **设置薪资** - 进入"设置"标签页，输入你的月薪、工作天数和每日工时
2. **开始摸鱼** - 点击"开始摸鱼"按钮，观察收入实时增长
3. **暂停/继续** - 随时暂停或继续计时
4. **查看战绩** - 切换到"分享"标签页查看当前收益
5. **分享炫耀** - 点击"分享战绩"生成图片分享给朋友
6. **老板来了** - 双击屏幕任意位置触发伪装界面

## 项目特点

- **纯 SwiftUI** - 100% SwiftUI 实现，无 UIKit 依赖
- **现代架构** - 使用 ObservableObject + EnvironmentObject 状态管理
- **TDD 开发** - 核心逻辑配有单元测试
- **代码规范** - 清晰的文件结构和命名规范

## 贡献

欢迎提交 Issue 和 Pull Request！

## 许可证

MIT License - 详见 [LICENSE](LICENSE) 文件

---

**摸鱼有理，打工人加油！** 💪🐟
