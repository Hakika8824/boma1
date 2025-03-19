param(
    [Parameter(Mandatory=$true)]
    [string]$CommitMessage
)

Write-Host "🔄 Saving progress..." -ForegroundColor Cyan

# Add all changes
git add .
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to add changes" -ForegroundColor Red
    exit 1
}

# Commit changes
git commit -m "$CommitMessage"
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to commit changes" -ForegroundColor Red
    exit 1
}

# Push to remote
git push origin master
if ($LASTEXITCODE -ne 0) {
    Write-Host "❌ Failed to push changes" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Progress saved successfully!" -ForegroundColor Green
Write-Host "Committed and pushed with message: $CommitMessage" -ForegroundColor Yellow 