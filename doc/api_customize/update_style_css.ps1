# ファイルパスの指定
$filePath = "doc\api\static-assets\styles.css"

# 変更前の文字列（正規表現）
$searchPattern = [regex]::Escape(@"
.sidebar-offcanvas-left {
  flex: 0 1 230px;
  order: 1;
  overflow-y: scroll;
  padding: 20px 0 15px 30px;
  margin: 5px 20px 0 0;
}
"@).Replace("\r", "").Replace("\n", "\r?\n")

# 変更後の文字列
$replacement = @"
.sidebar-offcanvas-left {
  flex: 0 1 600px;
  order: 1;
  overflow-y: scroll;
  padding: 20px 0 15px 30px;
  margin: 5px 20px 0 0;
}
"@

# ファイルの内容を読み込む
$fileContent = Get-Content -Path $filePath -Raw

# 改行コードをLFに統一
$fileContent = $fileContent -replace "`r`n", "`n"

# 文字列の置換
$fileContent = [regex]::Replace($fileContent, $searchPattern, $replacement)

# 変更内容をファイルに書き込む（LF形式で書き込み）
Set-Content -Path $filePath -Value $fileContent -NoNewline

Write-Output "The file has been updated successfully."
