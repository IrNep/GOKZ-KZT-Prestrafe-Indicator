## 简介 Description:

 * 将KZT玩家的地速状态可视化
 * Show KZT players prestrafe status. 

## 依赖 Dependency: 

 * [GOKZ](https://github.com/KZGlobalTeam/gokz/releases)

## 安装 How To Install:
 1. 从[发布](https://github.com/IrNep/GOKZ-KZT-Prestrafe-Indicator/releases)页面下载插件包. Download from [releases](https://github.com/IrNep/GOKZ-KZT-Prestrafe-Indicator/releases).
 2. 解压至 服务端根目录/csgo/ 下. Uncompress files into server_file/csgo/.

## 使用 How To Use:

 * Command: 
    * !pre -- 切换可视化模式 / Switch indicator style
 * Options:
    * !options -> HUD -> 地速指示器 / Prestrafe Indicator

## 风格 Indicator Styles:

 * 血量与护甲 Health And Armor
    * Health indicates Prestrafe Percentage 血量代表地速大小
    * Armor indicates Prestrafe Tick Counter 护甲代表地速Tick
    * This style only work for self and spectators options wont effect players 该模式仅影响自身和正在观察自己的观察者
  
 * 中心下方 Bottom
    * First line indicates max prestrafe speed that player can reach 第一行代表地速大小
    * Second line indicates Prestrafe Tick Counter with brackets 第二行代表地速Tick
    * Text Turn red when Tick Counter reach 73 indicate prestrafe decreasing 地速进入下降阶段时两值变红
    * This style work for any kzt players including replay bots 该模式可在观察KZT玩家/BOT时生效


## 约束 Restriction:
 * *仅*在KZT模式生效 Work on kzt *only*. 

 * 血量与护甲模式在会掉血的地图中将**不会**生效(目前gokz api没有给出相应接口, 暂时以黑名单进行管控: addons/sourcemod/configs/gokz_health_base_maps.txt)
 * Health style **won't** work on maps that use fall damage(currently undefined in gokz api so it is controlled by blacklist: addons/sourcemod/configs/gokz_health_base_maps.txt).
