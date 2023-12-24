# 执行 wsl 命令
Invoke-Expression "wsl -l --all -v"
# 获取退出代码
$exitCode = $LASTEXITCODE
# 判断退出代码
if ($exitCode -ne 0) {
    Write-Host "脚本出错，退出代码为: $exitCode"
    exit
} else {
    Write-Host "脚本执行成功，退出代码为: $exitCode"
}

# 获取用户输入项目名
$projectName = Read-Host "请输入项目名"

# 检查用户是否输入了项目名
if (-not $projectName) {
    Write-Host "项目名不能为空。"
    exit
}

# 打印用户输入的项目名
Write-Host "您输入的项目名是: $projectName"

# 获取文件路径
Write-Host "请选择导出文件目录："
Add-Type -AssemblyName System.Windows.Forms

# 创建文件选择对话框
$fileDialog = New-Object System.Windows.Forms.OpenFileDialog
$fileDialog.Title = "选择导出文件位置"
$fileDialog.Filter = "All Files (*.*)|*.*"
$fileDialog.InitialDirectory = [System.IO.Path]::GetFullPath("D:\")
$fileDialog.FileName = "$projectName.tar"
$fileDialog.CheckFileExists = $false  # 忽略文件是否存在

# 显示文件选择对话框
$result = $fileDialog.ShowDialog()

# 处理用户选择
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $exportFilePath = $fileDialog.FileName
    Write-Host "选择的导出文件位置：$exportFilePath"
} else {
    Write-Host "用户取消选择。"
    exit
}

# 创建文件选择对话框
Write-Host "选择新wsl系统位置"
$folderDialog = New-Object System.Windows.Forms.OpenFileDialog
$folderDialog.Title = "选择新wsl系统位置"
$folderDialog.SelectedPath = [System.IO.Path]::GetFullPath("D:\")

# 显示文件选择对话框
$result = $folderDialog.ShowDialog()

# 处理用户选择
if ($result -eq [System.Windows.Forms.DialogResult]::OK) {
    $newWslPath = $folderDialog.SelectedPath
    Write-Host "选择新wsl系统位置：$newWslPath"
} else {
    Write-Host "用户取消选择。"
    exit
}

# 导出
wsl --export $projectName $exportFilePath
# 获取退出代码
$exitCode = $LASTEXITCODE
# 打印退出代码
Write-Host "Exit Code: $exitCode"
if ($exitCode -ne 0) {
    Write-Host "脚本出错，退出代码为: $exitCode"
    exit
} else {
    Write-Host "脚本执行成功，退出代码为: $exitCode"
}

# 注销
wsl --unregister $projectName
# 重新导入
mkdir $newWslPath
wsl --import $projectName $newWslPath $exportFilePath --version 2
ubuntu config --default-user oldkingok
Remove-Item $exportFilePath
# ok
