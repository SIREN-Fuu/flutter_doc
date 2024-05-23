# ファイルパスの指定
$filePath = "doc\api\index.html"

# HTMLファイルの内容を読み込み
$htmlContent = Get-Content -Path $filePath -Raw -Encoding UTF8

# <section class="summary">タグの内容を抽出
$pattern = "(<section class=\""summary\"">\s*<h2>Libraries</h2>\s*<dl>)(.*?)(</dl>\s*</section>)"
$dtPattern = "<dt.*?>.*?</dt>\s*<dd.*?>.*?</dd>"

# <section class="summary">を含む<dl>ブロックを抽出
$blockMatches = [regex]::Matches($htmlContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

foreach ($match in $blockMatches) {
    # Write-Output "Found <section> block: $($match.Value)"

    # <dt>と<dd>タグのペアを抽出
    $dtMatches = [regex]::Matches($match.Groups[2].Value, $dtPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    if ($dtMatches.Count -eq 0) {
        Write-Output "No <dt> and <dd> pairs found."
        continue
    }

    # Write-Output "Found <dt> and <dd> pairs: $($dtMatches.Count)"

    # <dt>タグの内容をソート
    $sortedDtMatches = $dtMatches | Sort-Object { $_.Value -replace '<.*?>', '' }

    # ソートした<dt>タグを配列に変換
    $sortedDtArray = $sortedDtMatches | ForEach-Object { $_.Value }

    # ソートした<dt>タグを結合
    $sortedDtContent = $sortedDtArray -join "`n"

    # ソートした<dt>タグのブロックで元の<dt>タグのブロックを置き換え
    $replacement = "{0}`n{1}`n{2}" -f $match.Groups[1].Value, $sortedDtContent, $match.Groups[3].Value
    $htmlContent = $htmlContent -replace [regex]::Escape($match.Value), $replacement
}

# 変更されたHTMLファイルの内容を保存 (UTF-8エンコーディングを使用)
Set-Content -Path $filePath -Value $htmlContent -Encoding UTF8 -Force

Write-Output "The <dt> and <dd> tags have been sorted and the HTML file has been updated successfully."
