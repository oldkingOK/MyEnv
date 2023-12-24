while ($true) {
    
# 指定XML文件路径
$xmlFilePath = ".\wsl\scripts.xml"

# 加载XML文件
[xml]$xmlContent = Get-Content -Path $xmlFilePath

# 遍历XML内容，为每个文件添加序号
$index = 1
$files = @()

foreach ($fileEntry in $xmlContent.SelectNodes("//File")) {
    $fileName = $fileEntry.SelectSingleNode("FileName").InnerText
    $description = $fileEntry.SelectSingleNode("Description").InnerText

    # 输出文件信息带序号
    Write-Host "$index. $description - '$fileName'"
    
    # 存储文件信息到数组
    $files += [PSCustomObject]@{
        Index = $index
        FileName = $fileName
        Description = $description
    }

    $index++
}

# 提示用户选择序号
$userInput = Read-Host "请输入序号选择脚本"

# 根据用户选择的序号获取文件名
$selectedFile = $files | Where-Object { $_.Index -eq $userInput }

# 如果找到选择的文件，则执行命令
if ($selectedFile) {
    $selectedFileName = $selectedFile.FileName
    Write-Host "您选择的脚本为: $selectedFileName"
    Write-Host "开始执行脚本："
    Write-Host ""

    # 在这里执行您的命令，这里只是一个示例
    & $selectedFileName
} else {
    Write-Host "无效的序号。"
}

Pause
Write-Host ""
Write-Host "================================="
Write-Host ""

}
