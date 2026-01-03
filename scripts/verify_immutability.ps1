param (
    [string]$BucketName
)

if (-not $BucketName) {
    Write-Host "Usage: ./verify_immutability.ps1 -BucketName <bucket-name>" -ForegroundColor Red
    exit 1
}

Write-Host "Attempting to list bucket contents..." -ForegroundColor Cyan
aws s3 ls s3://$BucketName --recursive

Write-Host "`nAttempting to delete a test object (expected to FAIL)..." -ForegroundColor Cyan

$objectKey = aws s3 ls s3://$BucketName --recursive | Select-Object -First 1 | ForEach-Object { ($_ -split "\s+")[-1] }

if (-not $objectKey) {
    Write-Host "No object key found. Check Lambda logs for successful writes." -ForegroundColor Yellow
    exit 0
}

aws s3 rm "s3://$BucketName/$objectKey"

Write-Host "If deletion failed with AccessDenied/ObjectLocked, immutability is enforced." -ForegroundColor Green
