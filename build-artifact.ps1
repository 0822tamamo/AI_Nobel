# Build dist\novel-studio-artifact.html (claude.ai artifact version) from novel-studio.html.
# The artifact wraps the page in its own doctype/html/head/body at publish time, so strip those tags.
$src = Join-Path $PSScriptRoot 'novel-studio.html'
$dst = Join-Path $PSScriptRoot 'dist\novel-studio-artifact.html'
New-Item -ItemType Directory -Force (Split-Path $dst) | Out-Null
$html = [IO.File]::ReadAllText($src, [Text.Encoding]::UTF8)
$html = $html -replace '(?s)<!--pwa-->.*?<!--/pwa-->\s*', '' `
              -replace '(?i)<link rel="icon"[^>]*>\s*', '' `
              -replace '(?i)<!doctype html>\s*', '' `
              -replace '(?i)<html[^>]*>\s*', '' `
              -replace '(?i)<head>\s*', '' `
              -replace '(?i)<meta charset[^>]*>\s*', '' `
              -replace '(?i)<meta name="viewport"[^>]*>\s*', '' `
              -replace '(?i)</head>\s*', '' `
              -replace '(?i)<body>\s*', '' `
              -replace '(?i)</body>\s*', '' `
              -replace '(?i)</html>\s*', ''
[IO.File]::WriteAllText($dst, $html, (New-Object Text.UTF8Encoding $false))
"built: $dst"
