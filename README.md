# Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](LICENSE)
[![Markdown Lint](https://github.com/dknauss/skills/actions/workflows/markdown-lint.yml/badge.svg)](https://github.com/dknauss/skills/actions/workflows/markdown-lint.yml)
[![Link Check](https://github.com/dknauss/skills/actions/workflows/link-check.yml/badge.svg)](https://github.com/dknauss/skills/actions/workflows/link-check.yml)
[![Validate Skills](https://github.com/dknauss/skills/actions/workflows/validate-skills.yml/badge.svg)](https://github.com/dknauss/skills/actions/workflows/validate-skills.yml)

Standalone skill pack for GitHub and WordPress workflows. This repository is maintained as its own public distribution while acknowledging the original upstream project at [jdevalk/skills](https://github.com/jdevalk/skills).

## Installation

Download the `.skill` file you want from the [latest release in this repository](https://github.com/dknauss/skills/releases/latest) and open it in Claude, or copy the skill directory into your local skills folder.

## Project Status

- This repository ships its own releases and CI workflows.
- The content was originally forked from [jdevalk/skills](https://github.com/jdevalk/skills) and may diverge over time.
- Validation covers skill frontmatter, linked support files, and bundled eval fixtures before release packaging.

## What's Included

### GitHub Repo Optimizer

Audits a GitHub repository against best practices and generates the files that make a repo look professional: `README.md`, `CONTRIBUTING.md`, `SECURITY.md`, issue and PR templates, and related community files.

**Trigger phrases:** *"improve my repo"*, *"set up issue templates"*, *"make my GitHub project look professional"*

<details>
<summary><strong>Sources</strong></summary>

- Joost de Valk — [How to create a healthy GitHub repository](https://joost.blog/healthy-github-repository/)
- GitHub Docs — [About READMEs](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/about-readmes)
- GitHub Docs — [Setting guidelines for repository contributors](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/setting-guidelines-for-repository-contributors)
- GitHub Docs — [Creating a default community health file](https://docs.github.com/en/communities/setting-up-your-project-for-healthy-contributions/creating-a-default-community-health-file)
- GitHub Docs — [Configuring issue templates for your repository](https://docs.github.com/en/communities/using-templates-to-encourage-useful-issues-and-pull-requests/configuring-issue-templates-for-your-repository)
- GitHub Docs — [About rulesets](https://docs.github.com/en/repositories/configuring-branches-and-merges-in-your-repository/managing-rulesets/about-rulesets)
- GitHub Docs — [Customizing your repository's social media preview](https://docs.github.com/en/repositories/managing-your-repositorys-settings-and-features/customizing-your-repository/customizing-your-repositorys-social-media-preview)

</details>

### GitHub Profile Optimizer

Audits a GitHub profile page, scores the visible profile surface, and generates an optimized profile README for either personal or organization profiles.

**Trigger phrases:** *"make my GitHub look good"*, *"create a profile README"*, *"optimize my developer profile"*

<details>
<summary><strong>Sources</strong></summary>

- Joost de Valk — [Good-looking GitHub profile pages](https://joost.blog/good-looking-github-profile-pages/)
- GitHub Docs — [Managing your profile README](https://docs.github.com/en/account-and-profile/how-tos/profile-customization/managing-your-profile-readme)
- GitHub Docs — [About your profile](https://docs.github.com/en/account-and-profile/setting-up-and-managing-your-github-profile/customizing-your-profile/about-your-profile)
- GitHub Docs — [Customizing your organization's profile](https://docs.github.com/en/organizations/collaborating-with-groups-in-organizations/customizing-your-organizations-profile)
- GitHub Docs — [Contributions on your profile](https://docs.github.com/en/account-and-profile/concepts/contributions-on-your-profile)

</details>

### WordPress GitHub Actions

Sets up GitHub Actions CI/CD pipelines for WordPress plugins, including code quality checks, testing, static analysis, previews, and deployment guidance.

**Trigger phrases:** *"add CI to my WordPress plugin"*, *"set up GitHub Actions for my plugin"*, *"deploy my plugin to WordPress.org automatically"*

<details>
<summary><strong>Sources</strong></summary>

- Joost de Valk — [GitHub Actions to keep your WordPress plugin healthy](https://joost.blog/github-actions-wordpress/)
- [10up/wpcs-action](https://github.com/10up/wpcs-action)
- [10up/action-wordpress-plugin-deploy](https://github.com/10up/action-wordpress-plugin-deploy)
- [WordPress/action-wp-playground-pr-preview](https://github.com/WordPress/action-wp-playground-pr-preview)
- WordPress Developer Blog — [How to add automated unit tests to your WordPress plugin](https://developer.wordpress.org/news/2025/12/how-to-add-automated-unit-tests-to-your-wordpress-plugin/)

</details>

### WordPress Readme Optimizer

Reviews a WordPress.org plugin `readme.txt`, scores each section, and produces a rewritten version aimed at stronger search visibility and better install conversion.

**Trigger phrases:** *"optimize my readme"*, *"review my plugin listing"*, *"make my plugin page better"*

<details>
<summary><strong>Sources</strong></summary>

- Matt Cromwell — [How I Optimize Plugin README's for Better Search Results](https://mattcromwell.com/wordpress-plugin-readme-optimization/)
- Freemius — [Outrank Competitors' SEO on the WordPress.org Plugin Repository](https://freemius.com/blog/seo-on-new-plugin-repository/)
- Freemius — [A Guide to Optimizing Your Plugin's WordPress.org Page](https://freemius.com/blog/optimizing-plugin-wordpress-page/)
- WordPress Plugin Handbook — [How Your Plugin Assets Work](https://developer.wordpress.org/plugins/wordpress-org/plugin-assets/)
- SitePoint — [How To Create an Awesome WordPress Page for Your Plugin](https://www.sitepoint.com/create-awesome-wordpress-org-page-plugin/)

</details>

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for local validation, review expectations, and release hygiene.

## Security

See [SECURITY.md](SECURITY.md) for private reporting instructions. Do not use public issues for security reports.

## License

This project is licensed under the [MIT License](LICENSE).
