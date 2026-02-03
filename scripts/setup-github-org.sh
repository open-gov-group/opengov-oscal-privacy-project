#!/bin/bash
#
# Setup-Script für OpenGov Privacy Ecosystem GitHub Organisation
# Erstellt GitHub Teams, Project Boards und konfiguriert Repositories
#
# Voraussetzung: GitHub CLI (gh) installiert und authentifiziert
# Installation:
#   macOS: brew install gh
#   Linux: https://github.com/cli/cli/blob/trunk/docs/install_linux.md
# Auth: gh auth login
#
# Verwendung:
#   ./setup-github-org.sh              # Normal ausführen
#   ./setup-github-org.sh --dry-run    # Nur anzeigen, nichts ändern

set -e

# ============================================================================
# KONFIGURATION
# ============================================================================

ORG="open-gov-group"
DRY_RUN=false

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --dry-run)
            DRY_RUN=true
            shift
            ;;
        --org)
            ORG="$2"
            shift 2
            ;;
        *)
            echo "Unbekannte Option: $1"
            exit 1
            ;;
    esac
done

# Farben
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
CYAN='\033[0;36m'
MAGENTA='\033[0;35m'
NC='\033[0m' # No Color

step() { echo -e "${CYAN}▶ $1${NC}"; }
success() { echo -e "${GREEN}✓ $1${NC}"; }
skip() { echo -e "${YELLOW}⊘ $1${NC}"; }
error() { echo -e "${RED}✗ $1${NC}"; }

# Teams Definition
declare -a TEAMS=(
    "steering-committee:Strategische Entscheidungen und Budget:closed"
    "architecture-team:Technische Architektur und ADRs:closed"
    "product-owner:Fachliche Priorisierung:closed"
    "compliance-team:OSCAL Kataloge und Standards:closed"
    "frontend-team:React/TypeScript Entwicklung:closed"
    "backend-team:Python/FastAPI Entwicklung:closed"
    "operations-team:DevOps und Deployment:closed"
    "security-team:Security Reviews:closed"
    "tech-leads:Alle Team Leads:closed"
    "devops-team:CI/CD und Automatisierung:closed"
)

# Repository-Team-Zuordnung
declare -a REPOSITORIES=(
    "opengov-oscal-privacy-project:architecture-team:admin"
    "opengov-privacy-oscal:compliance-team:maintain"
    "opengov-security-oscal:compliance-team:maintain"
    "opengov-privacy-mappings:compliance-team:maintain"
    "opengov-oscal-privacy-viewer:frontend-team:maintain"
    "opengov-privacy-app:tech-leads:maintain"
    "opengov-oscal-workbench:frontend-team:maintain"
    "opengov-privacy-gateway:backend-team:maintain"
    "opengov-oscal-pyprivacy:backend-team:maintain"
    "opengov-pylegal-utils:backend-team:maintain"
    "opengov-privacy-data:operations-team:maintain"
)

# ============================================================================
# PRÜFUNGEN
# ============================================================================

echo ""
echo -e "${MAGENTA}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${MAGENTA}║     OpenGov Privacy Ecosystem - GitHub Organisation Setup      ║${NC}"
echo -e "${MAGENTA}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Prüfe gh CLI
step "Prüfe GitHub CLI Installation..."
if ! command -v gh &> /dev/null; then
    error "GitHub CLI nicht gefunden!"
    echo "  Installation: brew install gh (macOS) oder siehe https://cli.github.com/"
    exit 1
fi
GH_VERSION=$(gh --version | head -1)
success "GitHub CLI gefunden: $GH_VERSION"

# Prüfe Authentifizierung
step "Prüfe GitHub Authentifizierung..."
if ! gh auth status &> /dev/null; then
    error "Nicht bei GitHub angemeldet!"
    echo "  Ausführen: gh auth login"
    exit 1
fi
success "Authentifiziert"

# Prüfe Org-Zugriff
step "Prüfe Zugriff auf Organisation '$ORG'..."
if ! gh api "orgs/$ORG" &> /dev/null; then
    error "Kein Zugriff auf Organisation '$ORG'!"
    echo "  Stellen Sie sicher, dass Sie Org-Admin sind"
    exit 1
fi
ORG_NAME=$(gh api "orgs/$ORG" --jq '.name')
success "Organisation gefunden: $ORG_NAME"

if [ "$DRY_RUN" = true ]; then
    echo ""
    echo -e "${YELLOW}⚠ DRY-RUN MODUS - Keine Änderungen werden durchgeführt${NC}"
    echo ""
fi

# ============================================================================
# TEAMS ERSTELLEN
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo "  SCHRITT 1: GitHub Teams erstellen"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

for team_def in "${TEAMS[@]}"; do
    IFS=':' read -r name description privacy <<< "$team_def"

    step "Team: $name"

    # Prüfe ob Team existiert
    if gh api "orgs/$ORG/teams/$name" &> /dev/null; then
        skip "Team existiert bereits"
    else
        if [ "$DRY_RUN" = true ]; then
            echo "  [DRY-RUN] Würde Team erstellen"
        else
            if gh api "orgs/$ORG/teams" \
                -X POST \
                -f name="$name" \
                -f description="$description" \
                -f privacy="$privacy" &> /dev/null; then
                success "Team erstellt"
            else
                error "Fehler beim Erstellen"
            fi
        fi
    fi
done

# ============================================================================
# TEAM-BERECHTIGUNGEN FÜR REPOSITORIES
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo "  SCHRITT 2: Team-Berechtigungen für Repositories setzen"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

for repo_def in "${REPOSITORIES[@]}"; do
    IFS=':' read -r repo_name team permission <<< "$repo_def"

    step "Repository: $repo_name"

    # Prüfe ob Repo existiert
    if ! gh api "repos/$ORG/$repo_name" &> /dev/null; then
        skip "Repository existiert nicht (noch nicht erstellt)"
        continue
    fi

    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY-RUN] Würde Team '$team' mit '$permission' berechtigen"
    else
        if gh api "orgs/$ORG/teams/$team/repos/$ORG/$repo_name" \
            -X PUT \
            -f permission="$permission" &> /dev/null; then
            success "Team '$team' berechtigt mit '$permission'"
        else
            error "Fehler beim Setzen der Berechtigung"
        fi
    fi

    # Architecture-Team bekommt immer Read-Zugriff
    if [ "$team" != "architecture-team" ]; then
        if [ "$DRY_RUN" = true ]; then
            echo "  [DRY-RUN] Würde 'architecture-team' mit 'push' berechtigen"
        else
            gh api "orgs/$ORG/teams/architecture-team/repos/$ORG/$repo_name" \
                -X PUT \
                -f permission="push" &> /dev/null || true
        fi
    fi
done

# ============================================================================
# PROJECT BOARD ERSTELLEN
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo "  SCHRITT 3: Organization Project Board erstellen"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════${NC}"
echo ""

step "Ecosystem Roadmap Board"

# Prüfe ob Project existiert
EXISTING_PROJECT=$(gh api graphql -f query='
query($org: String!) {
  organization(login: $org) {
    projectsV2(first: 10) {
      nodes {
        title
      }
    }
  }
}' -f org="$ORG" --jq '.data.organization.projectsV2.nodes[].title' 2>/dev/null | grep -x "Ecosystem Roadmap" || true)

if [ -n "$EXISTING_PROJECT" ]; then
    skip "Project Board existiert bereits"
else
    if [ "$DRY_RUN" = true ]; then
        echo "  [DRY-RUN] Würde Project Board erstellen"
    else
        # Hole Org ID
        ORG_ID=$(gh api graphql -f query='
        query($org: String!) {
          organization(login: $org) {
            id
          }
        }' -f org="$ORG" --jq '.data.organization.id')

        # Erstelle Project
        PROJECT_URL=$(gh api graphql -f query='
        mutation($orgId: ID!, $title: String!) {
          createProjectV2(input: {ownerId: $orgId, title: $title}) {
            projectV2 {
              url
            }
          }
        }' -f orgId="$ORG_ID" -f title="Ecosystem Roadmap" --jq '.data.createProjectV2.projectV2.url' 2>/dev/null)

        if [ -n "$PROJECT_URL" ]; then
            success "Project Board erstellt: $PROJECT_URL"
        else
            error "Fehler beim Erstellen des Project Boards"
        fi
    fi
fi

# ============================================================================
# ZUSAMMENFASSUNG
# ============================================================================

echo ""
echo -e "${GREEN}╔════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                      Setup abgeschlossen                        ║${NC}"
echo -e "${GREEN}╚════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}Nächste Schritte:${NC}"
echo "  1. Teammitglieder zu den Teams hinzufügen:"
echo "     https://github.com/orgs/$ORG/teams"
echo ""
echo "  2. Project Board konfigurieren (Custom Fields):"
echo "     https://github.com/orgs/$ORG/projects"
echo ""
echo "  3. CODEOWNERS in Sub-Repositories kopieren:"
echo "     Siehe: templates/repo-template/.github/CODEOWNERS"
echo ""
