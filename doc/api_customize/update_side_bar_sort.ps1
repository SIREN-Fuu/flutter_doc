# ファイルパスの指定
$filePath = "path\to\your\file.html"

# HTMLファイルの内容を読み込み
$htmlContent = Get-Content -Path $filePath -Raw

# <li>タグの内容を抽出
$liPattern = '<li>.*?</li>'
$liMatches = [regex]::Matches($htmlContent, $liPattern)

# <li>タグの内容をソート
$sortedLiMatches = $liMatches | Sort-Object { $_.Value -replace '<.*?>', '' }

# ソートした<li>タグを結合
$sortedLiContent = $sortedLiMatches | ForEach-Object { $_.Value } -join "`n"

# ソートした<li>タグのブロックで元の<li>タグのブロックを置き換え
$updatedHtmlContent = [regex]::Replace($htmlContent, "(<li class=\"section-title\">Libraries</li>)(.*?)</ol>", "`$1`n$sortedLiContent`n</ol>", [regexoptions]::Singleline)

# 変更されたHTMLファイルの内容を保存
Set-Content -Path $filePath -Value $updatedHtmlContent

Write-Output "The <li> tags have been sorted and the HTML file has been updated successfully."
