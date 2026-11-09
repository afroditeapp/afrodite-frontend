# Changelog

## [Unreleased]

### Added

- Add admin "Latest content" screen for browsing latest profile names,
  profile texts and media content
- Add admin "View accounts (advanced)" screen for filtering accounts and
  selecting which extra info is shown while browsing accounts

### Changed

- Allow rejecting media content with rejection reason details on the
  admin content management screen
- Show image usage info on the admin content management screen

## [0.26.0] - 2026-11-05

### Changed

- Allow '+' character in local part of email address
- Reorganize admin tasks UI
- Refresh admin task list item silently when returning from a task screen

### Fixed

- Show moderator tasks reports item when user has report processing
  permission but no profile name moderation permission

## [0.25.5] - 2026-11-02

### Added

- Show which type of admin banned the account on the account banned screen

### Changed

- Improve AI face verification description strings

### Fixed

- Breaking change: Fix admin API post_set_news_publicity HTTP method from
  DELETE to POST.

## [0.25.4] - 2026-10-28

- DB stability
- User API stability
