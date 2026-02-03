<#
.SYNOPSIS
    Setup-Script für OpenGov Privacy Ecosystem GitHub Organisation
.DESCRIPTION
    Erstellt GitHub Teams, Project Boards und konfiguriert Repositories
.NOTES
    Voraussetzung: GitHub CLI (gh) installiert und authentifiziert
    Installation: winget install GitHub.cli
    Auth: gh auth login
#>

param(
    [string]$Org = "open-gov-group",
    [switch]$DryRun = $false
)

$ErrorActionPreference = "Stop"

# Farben für Output
function Write-Step { param($msg) Write-Host "▶ $msg" -ForegroundColor Cyan }
function Write-Success { param($msg) Write-Host "✓ $msg" -ForegroundColor Green }
function Write-Skip { param($msg) Write-Host "⊘ $msg" -ForegroundColor Yellow }
function Write-Err { param($msg) Write-Host "✗ $msg" -ForegroundColor Red }

# ============================================================================
# KONFIGURATION
# ============================================================================

$Teams = @(
    @{ Name = "steering-committee"; Description = "Strategische Entscheidungen und Budget"; Privacy = "closed" }
    @{ Name = "architecture-team"; Description = "Technische Architektur und ADRs"; Privacy = "closed" }
    @{ Name = "product-owner"; Description = "Fachliche Priorisierung"; Privacy = "closed" }
    @{ Name = "compliance-team"; Description = "OSCAL Kataloge und Standards"; Privacy = "closed" }
    @{ Name = "frontend-team"; Description = "React/TypeScript Entwicklung"; Privacy = "closed" }
    @{ Name = "backend-team"; Description = "Python/FastAPI Entwicklung"; Privacy = "closed" }
    @{ Name = "operations-team"; Description = "DevOps und Deployment"; Privacy = "closed" }
    @{ Name = "security-team"; Description = "Security Reviews"; Privacy = "closed" }
    @{ Name = "tech-leads"; Description = "Alle Team Leads"; Privacy = "closed" }
    @{ Name = "devops-team"; Description = "CI/CD und Automatisierung"; Privacy = "closed" }
)

$Repositories = @(
    @{ Name = "opengov-oscal-privacy-project"; Team = "architecture-team"; Permission = "admin" }
    @{ Name = "opengov-privacy-oscal"; Team = "compliance-team"; Permission = "maintain" }
    @{ Name = "opengov-security-oscal"; Team = "compliance-team"; Permission = "maintain" }
    @{ Name = "opengov-privacy-mappings"; Team = "compliance-team"; Permission = "maintain" }
    @{ Name = "opengov-oscal-privacy-viewer"; Team = "frontend-team"; Permission = "maintain" }
    @{ Name = "opengov-privacy-app"; Team = "tech-leads"; Permission = "maintain" }
    @{ Name = "opengov-oscal-workbench"; Team = "frontend-team"; Permission = "maintain" }
    @{ Name = "opengov-privacy-gateway"; Team = "backend-team"; Permission = "maintain" }
    @{ Name = "opengov-oscal-pyprivacy"; Team = "backend-team"; Permission = "maintain" }
    @{ Name = "opengov-pylegal-utils"; Team = "backend-team"; Permission = "maintain" }
    @{ Name = "opengov-privacy-data"; Team = "operations-team"; Permission = "maintain" }
)

# ============================================================================
# PRÜFUNGEN
# ============================================================================

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Magenta
Write-Host "║     OpenGov Privacy Ecosystem - GitHub Organisation Setup      ║" -ForegroundColor Magenta
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Magenta
Write-Host ""

# Prüfe gh CLI
Write-Step "Prüfe GitHub CLI Installation..."
try {
    $ghVersion = gh --version | Select-Object -First 1
    Write-Success "GitHub CLI gefunden: $ghVersion"
} catch {
    Write-Err "GitHub CLI nicht gefunden!"
    Write-Host "  Installation: winget install GitHub.cli" -ForegroundColor Gray
    exit 1
}

# Prüfe Authentifizierung
Write-Step "Prüfe GitHub Authentifizierung..."
try {
    $authStatus = gh auth status 2>&1
    if ($LASTEXITCODE -ne 0) {
        throw "Nicht authentifiziert"
    }
    Write-Success "Authentifiziert"
} catch {
    Write-Err "Nicht bei GitHub angemeldet!"
    Write-Host "  Ausführen: gh auth login" -ForegroundColor Gray
    exit 1
}

# Prüfe Org-Zugriff
Write-Step "Prüfe Zugriff auf Organisation '$Org'..."
try {
    $orgInfo = gh api "orgs/$Org" 2>&1 | ConvertFrom-Json
    Write-Success "Organisation gefunden: $($orgInfo.name)"
} catch {
    Write-Err "Kein Zugriff auf Organisation '$Org'!"
    Write-Host "  Stellen Sie sicher, dass Sie Org-Admin sind" -ForegroundColor Gray
    exit 1
}

if ($DryRun) {
    Write-Host ""
    Write-Host "⚠ DRY-RUN MODUS - Keine Änderungen werden durchgeführt" -ForegroundColor Yellow
    Write-Host ""
}

# ============================================================================
# TEAMS ERSTELLEN
# ============================================================================

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SCHRITT 1: GitHub Teams erstellen"
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

foreach ($team in $Teams) {
    Write-Step "Team: $($team.Name)"

    # Prüfe ob Team existiert
    $existingTeam = gh api "orgs/$Org/teams/$($team.Name)" 2>$null | ConvertFrom-Json -ErrorAction SilentlyContinue

    if ($existingTeam) {
        Write-Skip "Team existiert bereits"
    } else {
        if ($DryRun) {
            Write-Host "  [DRY-RUN] Würde Team erstellen" -ForegroundColor Gray
        } else {
            try {
                $body = @{
                    name = $team.Name
                    description = $team.Description
                    privacy = $team.Privacy
                } | ConvertTo-Json

                gh api "orgs/$Org/teams" -X POST --input - <<< $body | Out-Null
                Write-Success "Team erstellt"
            } catch {
                Write-Err "Fehler beim Erstellen: $_"
            }
        }
    }
}

# ============================================================================
# TEAM-BERECHTIGUNGEN FÜR REPOSITORIES
# ============================================================================

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SCHRITT 2: Team-Berechtigungen für Repositories setzen"
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

foreach ($repo in $Repositories) {
    Write-Step "Repository: $($repo.Name)"

    # Prüfe ob Repo existiert
    $existingRepo = gh api "repos/$Org/$($repo.Name)" 2>$null | ConvertFrom-Json -ErrorAction SilentlyContinue

    if (-not $existingRepo) {
        Write-Skip "Repository existiert nicht (noch nicht erstellt)"
        continue
    }

    if ($DryRun) {
        Write-Host "  [DRY-RUN] Würde Team '$($repo.Team)' mit '$($repo.Permission)' berechtigen" -ForegroundColor Gray
    } else {
        try {
            gh api "orgs/$Org/teams/$($repo.Team)/repos/$Org/$($repo.Name)" `
                -X PUT `
                -f permission=$($repo.Permission) | Out-Null
            Write-Success "Team '$($repo.Team)' berechtigt mit '$($repo.Permission)'"
        } catch {
            Write-Err "Fehler: $_"
        }
    }

    # Architecture-Team bekommt immer Read-Zugriff
    if ($repo.Team -ne "architecture-team") {
        if ($DryRun) {
            Write-Host "  [DRY-RUN] Würde 'architecture-team' mit 'push' berechtigen" -ForegroundColor Gray
        } else {
            try {
                gh api "orgs/$Org/teams/architecture-team/repos/$Org/$($repo.Name)" `
                    -X PUT `
                    -f permission=push | Out-Null
                Write-Success "Architecture-Team berechtigt"
            } catch {
                # Ignoriere Fehler wenn Team nicht existiert
            }
        }
    }
}

# ============================================================================
# PROJECT BOARD ERSTELLEN
# ============================================================================

Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "  SCHRITT 3: Organization Project Board erstellen"
Write-Host "═══════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host ""

Write-Step "Ecosystem Roadmap Board"

# Prüfe ob Project existiert
$projects = gh api graphql -f query='
query($org: String!) {
  organization(login: $org) {
    projectsV2(first: 10) {
      nodes {
        title
        id
      }
    }
  }
}' -f org=$Org 2>$null | ConvertFrom-Json

$existingProject = $projects.data.organization.projectsV2.nodes | Where-Object { $_.title -eq "Ecosystem Roadmap" }

if ($existingProject) {
    Write-Skip "Project Board existiert bereits"
} else {
    if ($DryRun) {
        Write-Host "  [DRY-RUN] Würde Project Board erstellen" -ForegroundColor Gray
    } else {
        try {
            # Hole Org ID
            $orgData = gh api graphql -f query='
            query($org: String!) {
              organization(login: $org) {
                id
              }
            }' -f org=$Org | ConvertFrom-Json

            $orgId = $orgData.data.organization.id

            # Erstelle Project
            $projectResult = gh api graphql -f query='
            mutation($orgId: ID!, $title: String!) {
              createProjectV2(input: {ownerId: $orgId, title: $title}) {
                projectV2 {
                  id
                  url
                }
              }
            }' -f orgId=$orgId -f title="Ecosystem Roadmap" | ConvertFrom-Json

            $projectUrl = $projectResult.data.createProjectV2.projectV2.url
            Write-Success "Project Board erstellt: $projectUrl"

        } catch {
            Write-Err "Fehler beim Erstellen: $_"
        }
    }
}

# ============================================================================
# ZUSAMMENFASSUNG
# ============================================================================

Write-Host ""
Write-Host "╔════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                      Setup abgeschlossen                        ║" -ForegroundColor Green
Write-Host "╚════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "Nächste Schritte:" -ForegroundColor Cyan
Write-Host "  1. Teammitglieder zu den Teams hinzufügen:" -ForegroundColor White
Write-Host "     https://github.com/orgs/$Org/teams" -ForegroundColor Gray
Write-Host ""
Write-Host "  2. Project Board konfigurieren (Custom Fields):" -ForegroundColor White
Write-Host "     https://github.com/orgs/$Org/projects" -ForegroundColor Gray
Write-Host ""
Write-Host "  3. CODEOWNERS in Sub-Repositories kopieren:" -ForegroundColor White
Write-Host "     Siehe: templates/repo-template/.github/CODEOWNERS" -ForegroundColor Gray
Write-Host ""
