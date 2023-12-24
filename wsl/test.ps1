Add-Type -AssemblyName System.Windows.Forms

# 创建文件选择对话框
$fileDialog = New-Object System.Windows.Forms.OpenFileDialog
$fileDialog.Title = "选择导出文件位置"
$fileDialog.Filter = "All Files (*.*)|*.*"
$fileDialog.InitialDirectory = [System.IO.Path]::GetFullPath(".\")

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
