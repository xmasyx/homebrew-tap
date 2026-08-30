#!/usr/bin/env bash
# Rewrites a cask's `version` and `sha256` from the latest GitHub release of its repo.
#
#   Scripts/bump.sh nosleep            # one cask
#   Scripts/bump.sh --all              # every cask in Casks/
#
# Idempotent: when the cask already says the latest version, nothing is written and the exit
# code is 0. Exit 3 when the release asset cannot be downloaded, so a broken release never
# turns into a cask that fails at install time. No secrets: the GitHub API is read anonymously
# (or with GITHUB_TOKEN when the environment has one, which is the case inside Actions).
set -euo pipefail

ROOT="$(cd "$(dirname "$0")/.." && pwd)"
CASKS="$ROOT/Casks"

die() { echo "bump: $*" >&2; exit 3; }

api() {
    # $1 = path under https://api.github.com
    if [[ -n "${GITHUB_TOKEN:-}" ]]; then
        curl -fsSL -H "Authorization: Bearer $GITHUB_TOKEN" -H "Accept: application/vnd.github+json" "https://api.github.com/$1"
    else
        curl -fsSL -H "Accept: application/vnd.github+json" "https://api.github.com/$1"
    fi
}

bump_one() {
    local token="$1"
    local cask="$CASKS/$token.rb"
    [[ -f "$cask" ]] || die "no such cask: $cask"

    # The repo is the homepage; the asset name is the url line with #{version} substituted.
    local repo url_tpl current
    repo="$(sed -nE 's|^ *homepage "https://github.com/([^"]+)".*|\1|p' "$cask")"
    url_tpl="$(sed -nE 's|^ *url "([^"]+)".*|\1|p' "$cask")"
    current="$(sed -nE 's|^ *version "([^"]+)".*|\1|p' "$cask")"
    [[ -n "$repo" && -n "$url_tpl" && -n "$current" ]] || die "$cask: cannot read homepage/url/version"

    local tag latest
    tag="$(api "repos/$repo/releases/latest" | sed -nE 's|^ *"tag_name": *"([^"]+)".*|\1|p' | head -1)"
    [[ -n "$tag" ]] || die "$repo: no latest release on GitHub"
    latest="${tag#v}"

    if [[ "$latest" == "$current" ]]; then
        echo "$token: already at $current"
        return 0
    fi

    local url tmp sha
    url="${url_tpl//\#\{version\}/$latest}"
    tmp="$(mktemp)"
    trap 'rm -f "$tmp"' RETURN
    curl -fsSL -o "$tmp" "$url" || die "$token: cannot download $url"
    sha="$(shasum -a 256 "$tmp" | cut -d' ' -f1)"

    # Two exact-line rewrites, nothing else in the file moves.
    sed -i '' -E "s|^( *version )\"$current\"|\1\"$latest\"|" "$cask"
    sed -i '' -E "s|^( *sha256 )\"[0-9a-f]{64}\"|\1\"$sha\"|" "$cask"
    grep -q "version \"$latest\"" "$cask" || die "$token: version rewrite failed"
    grep -q "sha256 \"$sha\"" "$cask" || die "$token: sha256 rewrite failed"
    echo "$token: $current → $latest ($sha)"
}

if [[ "${1:-}" == "--all" ]]; then
    for f in "$CASKS"/*.rb; do bump_one "$(basename "$f" .rb)"; done
elif [[ -n "${1:-}" ]]; then
    bump_one "$1"
else
    echo "usage: $0 <cask-token> | --all" >&2
    exit 2
fi
