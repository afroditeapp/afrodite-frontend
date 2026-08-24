#!/usr/bin/env python3
"""Manage the Afrodite web release git repository content.

The web release packages are tar.gz archives produced by the Makefile
`build-web-release` target. Each archive contains a single version directory
(e.g. `1.2.3_1234567/`) which is served under `/app/<VERSION>/` because the
build uses `--base-href=/app/<VERSION>/`.

This script acts as a content manager for a git repository that serves the web
releases. It extracts the new version package into the repo, keeps only the
latest three version directories under `app/`, copies the newest version's
`index.html` to both the repo root and `app/`, and updates a Cloudflare Pages
`_headers` file. It only writes working-tree files; git commits are left to
the user. Only the Python standard library is used.

Repo file hierarchy:

    <repo-dir>/
      index.html          # root landing - copy of latest version's index.html
      _headers            # Cloudflare Pages headers
      app/
        index.html        # copy of latest version's index.html
        <VERSION>/        # one dir per release, e.g. 1.2.3_1234567
          index.html       # built with --base-href=/app/<VERSION>/ baked in
          ...
"""

import argparse
import gzip
import os
import re
import shutil
import subprocess
import sys
import tarfile
import tempfile

# One year in seconds, used for the immutable cache headers.
IMMUTABLE_MAX_AGE = 31556952

def parse_args(argv):
    parser = argparse.ArgumentParser(
        description="Manage Afrodite web release git repository content."
    )
    parser.add_argument(
        "tar_gz",
        metavar="TAR_GZ",
        help="Path to the new web release tar.gz package.",
    )
    parser.add_argument(
        "repo_dir",
        metavar="REPO_DIR",
        help="Path to the git repository directory to manage.",
    )
    parser.add_argument(
        "--allow-bots",
        action="store_true",
        help="Allow search engine bots by omitting the X-Robots-Tag header.",
    )
    return parser.parse_args(argv)


def generate_headers(allow_bots, version_dirs):
    """Build the Cloudflare Pages _headers file content."""
    lines = ["/*"]
    if not allow_bots:
        lines.append("  X-Robots-Tag: noindex, nofollow")
    lines.append("  X-Content-Type-Options: nosniff")
    lines.append("  Referrer-Policy: no-referrer")
    lines.append("")
    # Every file under a version directory is immutable because the version
    # string is part of the directory name. Cloudflare Pages allows only one
    # `*` wildcard per path pattern, so the immutable header must be repeated
    # for each version dir (e.g. /app/1.2.3_1234567/*). The /app/index.html
    # and root /index.html are not covered here (they change each release).
    for v in sorted(version_dirs, key=version_sort_key, reverse=True):
        lines.append("/app/%s/*" % v)
        lines.append("  Cache-Control: public, max-age=%d, immutable" % IMMUTABLE_MAX_AGE)
        lines.append("")
    return "\n".join(lines)


def decompress_gz_files(root_dir):
    """Decompress every .gz file under root_dir in place.

    The Makefile gzips all non-PNG files before packaging, so the extracted
    version directory contains .gz files that must be decompressed before
    serving. The original .gz file is removed after decompression.
    """
    for root, _dirs, files in os.walk(root_dir):
        for f in files:
            if not f.endswith(".gz"):
                continue
            gz_path = os.path.join(root, f)
            out_path = gz_path[:-3]
            with gzip.open(gz_path, "rb") as gz_in, open(out_path, "wb") as out:
                shutil.copyfileobj(gz_in, out)
            os.remove(gz_path)


def extract_package(tar_path, app_dir):
    """Extract a web release tar.gz into app_dir and return the version dir path."""
    if not os.path.isfile(tar_path):
        raise RuntimeError("Package not found: %s" % tar_path)
    os.makedirs(app_dir, exist_ok=True)
    with tempfile.TemporaryDirectory() as tmp:
        with tarfile.open(tar_path, "r:gz") as tar:
            tar.extractall(tmp)
        entries = [
            e
            for e in os.listdir(tmp)
            if os.path.isdir(os.path.join(tmp, e))
        ]
        if len(entries) != 1:
            raise RuntimeError(
                "Expected exactly one version directory in %s, found: %s"
                % (tar_path, ", ".join(entries) or "none")
            )
        version_dir = entries[0]
        dest = os.path.join(app_dir, version_dir)
        if os.path.isdir(dest):
            print("Version %s already exists, skipping" % version_dir)
            return dest
        version_path = os.path.join(tmp, version_dir)
        decompress_gz_files(version_path)
        shutil.move(version_path, dest)
        print("Added version %s from %s" % (version_dir, tar_path))
        return dest


def version_sort_key(name):
    """Return a sort key for a version directory name.

    Version names look like `1.2.3_1234567` (the `+` from the pubspec
    version is replaced with `_` by the Makefile). Numeric segments are compared
    numerically so that `1.10` sorts after `1.2`.
    """
    parts = re.split(r"[._]", name)
    return [int(p) if p.isdigit() else p for p in parts]


def prune_old_versions(app_dir):
    """Delete all but the three newest version dirs under app_dir.

    The newly added version is already in app_dir (moved there by
    extract_package), so it is part of the sorted list. The three newest
    dirs are retained; the rest are deleted.
    """
    if not os.path.isdir(app_dir):
        return
    versions = [
        e
        for e in os.listdir(app_dir)
        if os.path.isdir(os.path.join(app_dir, e))
    ]
    versions.sort(key=version_sort_key, reverse=True)
    keep = set(versions[:3])
    for v in versions:
        if v in keep:
            continue
        shutil.rmtree(os.path.join(app_dir, v))
        print("Removed old version %s" % v)


def copy_index_html(version_dir, repo_dir):
    """Copy the version's index.html to the repo root and app/."""
    src = os.path.join(version_dir, "index.html")
    if not os.path.isfile(src):
        raise RuntimeError("index.html not found in %s" % version_dir)
    for dest in (os.path.join(repo_dir, "index.html"), os.path.join(repo_dir, "app", "index.html")):
        shutil.copyfile(src, dest)


def ensure_repo_clean(repo_dir):
    """Raise if the repo's working tree is not clean.

    Writes to the working tree can silently clobber uncommitted changes,
    so refuse to run unless the tree is clean.
    """
    status = subprocess.run(
        ["git", "-C", repo_dir, "status", "--porcelain"],
        capture_output=True,
        text=True,
    )
    if status.returncode != 0:
        raise RuntimeError("Failed to read git status in %s" % repo_dir)
    if status.stdout.strip():
        raise RuntimeError(
            "Refusing to run: %s has uncommitted changes. Commit or stash them first."
            % repo_dir
        )


def main(argv):
    args = parse_args(argv)
    if not os.path.isdir(args.repo_dir):
        raise RuntimeError("Repo directory not found: %s" % args.repo_dir)
    ensure_repo_clean(args.repo_dir)
    app_dir = os.path.join(args.repo_dir, "app")
    version_path = extract_package(args.tar_gz, app_dir)
    prune_old_versions(app_dir)
    version_dirs = [
        e
        for e in os.listdir(app_dir)
        if os.path.isdir(os.path.join(app_dir, e))
    ]
    copy_index_html(version_path, args.repo_dir)
    headers = generate_headers(args.allow_bots, version_dirs)
    with open(os.path.join(args.repo_dir, "_headers"), "w")as f:
        f.write(headers)
    print("Updated repo %s" % args.repo_dir)


if __name__ == "__main__":
    main(sys.argv[1:])
