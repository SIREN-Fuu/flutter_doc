# 対象ディレクトリの指定
$directoryPath = "doc\api"

# 対象ディレクトリ内のすべてのHTMLファイルを取得
$htmlFiles = Get-ChildItem -Path $directoryPath -Filter *.html -Recurse

foreach ($file in $htmlFiles) {
    # ファイルの内容を読み込み
    $htmlContent = Get-Content -Path $file.FullName -Raw -Encoding UTF8

    # <ol>タグの内容を抽出
    $pattern = "(<li class=\""section-title\"">Libraries</li>)(.*?)(</ol>)"
    $liPattern = '<li>.*?</li>'

    # <li class="section-title">Libraries</li>を含む<ol>ブロックを抽出
    $blockMatches = [regex]::Matches($htmlContent, $pattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)

    foreach ($match in $blockMatches) {
        # <li>タグの内容を抽出
        $liMatches = [regex]::Matches($match.Groups[2].Value, $liPattern)

        # <li>タグの内容をソート
        $sortedLiMatches = $liMatches | Sort-Object { $_.Value -replace '<.*?>', '' }

        # ソートした<li>タグを配列に変換
        $sortedLiArray = $sortedLiMatches | ForEach-Object { $_.Value }

        # ソートした<li>タグを結合
        $sortedLiContent = $sortedLiArray -join "`n"

        # ソートした<li>タグのブロックで元の<li>タグのブロックを置き換え
        $replacement = "{0}`n{1}`n{2}" -f $match.Groups[1].Value, $sortedLiContent, $match.Groups[3].Value
        $htmlContent = $htmlContent -replace [regex]::Escape($match.Value), $replacement
    }

    # 変更されたHTMLファイルの内容を保存 (UTF-8エンコーディングを使用)
    Set-Content -Path $file.FullName -Value $htmlContent -Encoding UTF8 -Force

    Write-Output "Processed: $($file.FullName)"
}

Write-Output "All HTML files have been processed and updated successfully."
