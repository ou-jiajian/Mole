#!/bin/bash
# Mole - 中文语言包（参考词表）
#
# 注意：本文件是汉化参考词表，Mole 的实际中文界面文本已直接内联在
# bin/、lib/、cmd/ 的源码输出中（V1.51.0 起采用硬编码中文方案），
# 本文件不再被任何脚本 source，仅作为术语对照与审校参考保留。

# ========== 通用文本 ==========
readonly TXT_OK="确定"
readonly TXT_CANCEL="取消"
readonly TXT_QUIT="退出"
readonly TXT_BACK="返回"
readonly TXT_SKIP="跳过"
readonly TXT_CONTINUE="继续"
readonly TXT_ERROR="错误"
readonly TXT_WARNING="警告"
readonly TXT_SUCCESS="成功"
readonly TXT_FAILED="失败"
readonly TXT_LOADING="加载中…"
readonly TXT_COLLECTING="正在采集…"

# ========== 主菜单 ==========
readonly TXT_MAIN_TITLE="Mole - Mac 清理优化工具"
readonly TXT_MAIN_MENU="请选择操作："
readonly TXT_MENU_CLEAN="Clean        清理磁盘空间"
readonly TXT_MENU_UNINSTALL="Uninstall    完全卸载应用"
readonly TXT_MENU_OPTIMIZE="Optimize     优化系统性能"
readonly TXT_MENU_ANALYZE="Analyze      分析磁盘占用"
readonly TXT_MENU_STATUS="Status       监控系统状态"
readonly TXT_MENU_HISTORY="History      查看清理记录"
readonly TXT_MENU_PURGE="Purge        清理项目产物"
readonly TXT_MENU_INSTALLER="Installer    查找删除安装包"
readonly TXT_MENU_TOUCHID="TouchID      配置 Touch ID"
readonly TXT_MENU_COMPLETION="Completion   设置命令补全"
readonly TXT_MENU_UPDATE="Update       更新到最新版本"
readonly TXT_MENU_REMOVE="Remove       移除 Mole"
readonly TXT_MENU_HELP="Help         显示帮助"
readonly TXT_MENU_VERSION="Version      显示版本"

# ========== Clean 命令 ==========
readonly TXT_CLEAN_TITLE="清理您的 Mac"
readonly TXT_CLEAN_DRY_RUN="预览模式，仅预览不删除"
readonly TXT_CLEAN_COMPLETE="清理完成"
readonly TXT_CLEAN_DRY_RUN_COMPLETE="预览完成 - 未做任何更改"
readonly TXT_CLEAN_NOTHING="无需清理"
readonly TXT_CLEAN_SPACE_FREED="可释放空间："
readonly TXT_CLEAN_ITEMS="项目数："
readonly TXT_CLEAN_CATEGORIES="分类："
readonly TXT_CLEAN_TRACKED="已统计清理："
readonly TXT_CLEAN_EXTERNAL="清理外置硬盘"

# ========== Uninstall 命令 ==========
readonly TXT_UNINSTALL_TITLE="卸载应用"
readonly TXT_UNINSTALL_SCANNING="正在扫描应用…"
readonly TXT_UNINSTALL_ABORTED="卸载已中止："
readonly TXT_UNINSTALL_DRY_RUN_COMPLETE="卸载预览完成"
readonly TXT_UNINSTALL_WOULD_REMOVE="将移除"
readonly TXT_UNINSTALL_REMOVED="已移除"
readonly TXT_UNINSTALL_NO_APPS="未找到可卸载的应用"
readonly TXT_UNINSTALL_UNKNOWN_OPTION="未知的卸载选项："

# ========== Optimize 命令 ==========
readonly TXT_OPTIMIZE_TITLE="优化 Mac"
readonly TXT_OPTIMIZE_DONE="优化完成"
readonly TXT_OPTIMIZE_ALREADY_OPTIMAL="已是最优"
readonly TXT_OPTIMIZE_NETWORK="网络栈已是最优"
readonly TXT_OPTIMIZE_PERMISSIONS="用户目录权限已是最优"
readonly TXT_OPTIMIZE_SPOTLIGHT="Spotlight 索引已是最优"
readonly TXT_OPTIMIZE_DNS="DNS 缓存已刷新"
readonly TXT_OPTIMIZE_MDNS="mDNSResponder 已重启"

# ========== Status 命令 ==========
readonly TXT_STATUS_TITLE="状态"
readonly TXT_STATUS_HEALTH="健康度"
readonly TXT_STATUS_CPU="处理器"
readonly TXT_STATUS_MEMORY="内存"
readonly TXT_STATUS_DISK="磁盘"
readonly TXT_STATUS_NETWORK="网络"
readonly TXT_STATUS_POWER="电源"
readonly TXT_STATUS_PROCESSES="进程"
readonly TXT_STATUS_LOAD="负载"
readonly TXT_STATUS_TOTAL="总计"
readonly TXT_STATUS_FREE="可用"
readonly TXT_STATUS_USED="已用"
readonly TXT_STATUS_SWAP="交换"
readonly TXT_STATUS_CACHED="缓存"
readonly TXT_STATUS_TEMP="温度"
readonly TXT_STATUS_READ="读"
readonly TXT_STATUS_WRITE="写"
readonly TXT_STATUS_DOWN="下行"
readonly TXT_STATUS_UP="上行"
readonly TXT_STATUS_BATTERY="电池"
readonly TXT_STATUS_HEALTHY="健康"
readonly TXT_STATUS_EXCELLENT="优秀"
readonly TXT_STATUS_ALL_CLEAR="一切正常"
readonly TXT_STATUS_NO_BATTERY="无电池"
readonly TXT_STATUS_NO_DATA="无数据"
readonly TXT_STATUS_NO_DISKS="未检测到磁盘"
readonly TXT_STATUS_COLLECTING="正在采集…"

# ========== Analyze 命令 ==========
readonly TXT_ANALYZE_TITLE="分析磁盘"
readonly TXT_ANALYZE_SCANNING="正在分析磁盘占用…"
readonly TXT_ANALYZE_TOTAL="总计："
readonly TXT_ANALYZE_FREE="可用"
readonly TXT_ANALYZE_SELECT="选择要探索的位置："
readonly TXT_ANALYZE_FILTER="筛选："
readonly TXT_ANALYZE_MATCHES="个匹配"
readonly TXT_ANALYZE_NO_MATCHES="没有匹配"
readonly TXT_ANALYZE_DELETING="正在删除："
readonly TXT_ANALYZE_TRASH="移至废纸篓"
readonly TXT_ANALYZE_DELETE_CONFIRM="删除："
readonly TXT_ANALYZE_ENTER_CONFIRM="按回车确认"
readonly TXT_ANALYZE_ESC_CANCEL="ESC 取消"

# ========== Purge 命令 ==========
readonly TXT_PURGE_TITLE="清理项目构建产物"
readonly TXT_PURGE_SELECT="选择要清理的构建产物"
readonly TXT_PURGE_COMPLETE="清理完成"
readonly TXT_PURGE_NO_ARTIFACTS="未找到要清理的构建产物"

# ========== 提示信息 ==========
readonly TXT_HINT_DRY_RUN="使用 --dry-run 预览，使用 --whitelist 管理受保护路径"
readonly TXT_HINT_SUDO_REQUIRED="系统清理需要 sudo 权限"
readonly TXT_HINT_SKIP="已跳过"
readonly TXT_HINT_CANCELED="已取消"
readonly TXT_HINT_FULL_DISK_ACCESS="请在系统设置中授予终端完全磁盘访问权限"

# ========== 错误信息 ==========
readonly TXT_ERR_PERMISSION_DENIED="权限被拒绝"
readonly TXT_ERR_NOT_FOUND="未找到"
readonly TXT_ERR_UPDATE_FAILED="更新失败"
readonly TXT_ERR_NIGHTLY_FAILED="Nightly 更新失败"

# ========== 确认信息 ==========
readonly TXT_CONFIRM_DELETE="确认删除这些项目？"
readonly TXT_CONFIRM_YES="是"
readonly TXT_CONFIRM_NO="否"
