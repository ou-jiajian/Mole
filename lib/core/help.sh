#!/bin/bash

show_clean_help() {
    echo "用法: mo clean [选项]"
    echo ""
    echo "通过清理缓存、日志和临时文件来释放磁盘空间。"
    echo ""
    echo "选项:"
    echo "  --dry-run, -n     预览清理效果，不做任何修改"
    echo "  --whitelist       管理受保护的路径"
    echo "  --debug           显示详细的操作日志"
    echo "  -h, --help       显示此帮助信息"
}

show_installer_help() {
    echo "用法: mo installer [选项]"
    echo ""
    echo "查找并删除安装包文件 (.dmg, .pkg, .iso, .xip, .zip)。"
    echo ""
    echo "选项:"
    echo "  --dry-run         预览安装包清理，不做任何修改"
    echo "  --debug           显示详细的操作日志"
    echo "  -h, --help        显示此帮助信息"
}

show_optimize_help() {
    echo "用法: mo optimize [选项]"
    echo ""
    echo "检查并维护系统健康状态，应用优化设置。"
    echo ""
    echo "选项:"
    echo "  --dry-run         预览优化效果，不做任何修改"
    echo "  --whitelist       管理受保护的项"
    echo "  --debug           显示详细的操作日志"
    echo "  -h, --help        显示此帮助信息"
}

show_touchid_help() {
    echo "用法: mo touchid [命令]"
    echo ""
    echo "配置 Touch ID 用于 sudo 身份验证。"
    echo ""
    echo "命令:"
    echo "  enable            启用 Touch ID 用于 sudo"
    echo "  disable           禁用 Touch ID 用于 sudo"
    echo "  status            显示当前 Touch ID 状态"
    echo ""
    echo "选项:"
    echo "  --dry-run         预览 Touch ID 更改，不修改 sudo 配置"
    echo "  -h, --help        显示此帮助信息"
    echo ""
    echo "如果未提供命令，将显示交互式菜单。"
}

show_uninstall_help() {
    echo "用法: mo uninstall [选项]"
    echo ""
    echo "交互式卸载应用及其残留文件。"
    echo ""
    echo "选项:"
    echo "  --dry-run         预览卸载效果，不做任何修改"
    echo "  --whitelist       不支持（请使用 clean/optimize）"
    echo "  --debug           显示详细的操作日志"
    echo "  -h, --help        显示此帮助信息"
}
