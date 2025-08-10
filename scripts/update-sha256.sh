#!/bin/bash

# Script to update SHA256 hashes in the Omnivore formula
# Usage: ./scripts/update-sha256.sh <version>

set -e

VERSION=${1:-0.1.0}

if [ -z "$1" ]; then
    echo "Usage: $0 <version>"
    echo "Example: $0 0.1.0"
    exit 1
fi

echo "Updating SHA256 hashes for Omnivore v${VERSION}..."

# Define platforms
declare -A PLATFORMS=(
    ["ARM64_MAC"]="aarch64-apple-darwin"
    ["X86_64_MAC"]="x86_64-apple-darwin"
    ["ARM64_LINUX"]="aarch64-unknown-linux-gnu"
    ["X86_64_LINUX"]="x86_64-unknown-linux-gnu"
)

# Temporary directory for downloads
TEMP_DIR=$(mktemp -d)
trap "rm -rf $TEMP_DIR" EXIT

# Function to download and calculate SHA256
calculate_sha256() {
    local platform_key=$1
    local platform_value=$2
    local url="https://github.com/Pranav-Karra-3301/omnivore/releases/download/v${VERSION}/omnivore-v${VERSION}-${platform_value}.tar.gz"
    local temp_file="${TEMP_DIR}/omnivore-${platform_value}.tar.gz"
    
    echo "Downloading ${platform_value}..."
    if curl -L -o "$temp_file" "$url" 2>/dev/null; then
        local sha256=$(shasum -a 256 "$temp_file" | cut -d' ' -f1)
        echo "  SHA256: ${sha256}"
        
        # Update the formula
        case $platform_key in
            "ARM64_MAC")
                sed -i.bak "s/sha256 \"REPLACE_WITH_ARM64_MAC_SHA256\"/sha256 \"${sha256}\"/" omnivore.rb
                ;;
            "X86_64_MAC")
                sed -i.bak "s/sha256 \"REPLACE_WITH_X86_64_MAC_SHA256\"/sha256 \"${sha256}\"/" omnivore.rb
                ;;
            "ARM64_LINUX")
                sed -i.bak "s/sha256 \"REPLACE_WITH_ARM64_LINUX_SHA256\"/sha256 \"${sha256}\"/" omnivore.rb
                ;;
            "X86_64_LINUX")
                sed -i.bak "s/sha256 \"REPLACE_WITH_X86_64_LINUX_SHA256\"/sha256 \"${sha256}\"/" omnivore.rb
                ;;
        esac
    else
        echo "  WARNING: Failed to download ${platform_value}"
        echo "  URL: ${url}"
    fi
}

# Update version in formula
echo "Updating version to ${VERSION}..."
sed -i.bak "s/version \".*\"/version \"${VERSION}\"/" omnivore.rb

# Calculate SHA256 for each platform
for platform_key in "${!PLATFORMS[@]}"; do
    calculate_sha256 "$platform_key" "${PLATFORMS[$platform_key]}"
done

# Clean up backup files
rm -f omnivore.rb.bak

echo ""
echo "Formula updated successfully!"
echo "Please review the changes with: git diff omnivore.rb"
echo ""
echo "To test the formula locally:"
echo "  brew install --build-from-source ./omnivore.rb"