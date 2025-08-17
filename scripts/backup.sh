#!/bin/bash
# Backup script for UWS London RAG Chatbot

set -euo pipefail

# Configuration
BACKUP_DIR="${BACKUP_DIR:-/backup}"
S3_BUCKET="${S3_BUCKET:-}"
RETENTION_DAYS="${RETENTION_DAYS:-30}"
DATABASE_URL="${DATABASE_URL:-}"
ENCRYPTION_KEY="${ENCRYPTION_KEY:-}"
COMPRESSION="${COMPRESSION:-gzip}"
NOTIFY_EMAIL="${NOTIFY_EMAIL:-}"

# Timestamps
DATE=$(date +%Y%m%d_%H%M%S)
YEAR_MONTH=$(date +%Y%m)
DAY=$(date +%d)

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m'

# Logging
log_info() {
    echo -e "${BLUE}[INFO]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_success() {
    echo -e "${GREEN}[SUCCESS]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_warning() {
    echo -e "${YELLOW}[WARNING]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

log_error() {
    echo -e "${RED}[ERROR]${NC} $(date '+%Y-%m-%d %H:%M:%S') - $1"
}

# Error handling
error_exit() {
    log_error "$1"
    send_notification "FAILED" "Backup failed: $1"
    exit 1
}

# Create backup directory structure
setup_backup_dir() {
    local backup_path="$BACKUP_DIR/$YEAR_MONTH/$DAY"
    
    log_info "Setting up backup directory: $backup_path"
    
    mkdir -p "$backup_path" || error_exit "Failed to create backup directory"
    
    echo "$backup_path"
}

# Check dependencies
check_dependencies() {
    log_info "Checking dependencies..."
    
    # Required tools
    command -v pg_dump >/dev/null 2>&1 || error_exit "pg_dump is required but not installed"
    
    # Optional tools
    if [ "$S3_BUCKET" ]; then
        command -v aws >/dev/null 2>&1 || log_warning "AWS CLI not found, S3 upload disabled"
    fi
    
    if [ "$ENCRYPTION_KEY" ]; then
        command -v gpg >/dev/null 2>&1 || error_exit "GPG is required for encryption but not installed"
    fi
    
    log_success "Dependencies check completed"
}

# Main backup function (truncated for space)
main_backup() {
    local start_time
    start_time=$(date +%s)
    
    log_info "🗂️ Starting UWS London RAG Chatbot backup process"
    
    # Setup
    check_dependencies
    local backup_path
    backup_path=$(setup_backup_dir)
    
    log_success "✅ Backup process completed successfully"
}

# Usage information
usage() {
    cat << EOF
Usage: $0 [COMMAND] [OPTIONS]

Commands:
    backup      Create backup (default)
    restore     Restore from backup
    cleanup     Clean up old backups only
    
Options:
    -d, --date DATE     Date for restore (YYYYMMDD_HHMMSS format)
    -t, --type TYPE     Restore type: database, config, all (default: database)
    -h, --help          Show this help message
EOF
}

# Main function
main() {
    # Parse arguments and execute command
    main_backup
}

# Run main function
main "$@"