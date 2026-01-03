param (
    [int]$Count = 5
)

Write-Host "Generating $Count audit events..." -ForegroundColor Cyan

for ($i = 1; $i -le $Count; $i++) {
    Write-Host "Emitting audit event $i"
    python3 /home/ec2-user/audit_emitter.py
    Start-Sleep -Seconds 1
}

Write-Host "Audit event generation completed." -ForegroundColor Green
