# Lab Website

This repository contains the source code for the lab's website, built with Pandoc and deployed to GitHub Pages.

## Repository Structure

```
.
├── Makefile           # Build commands
├── README.md          # This file
├── .gitignore         # Files to exclude from git
├── src/               # Source files
│   ├── index.md       # Homepage
│   ├── papers.md      # Publications page
│   ├── people.md      # Team page
│   ├── 404.md         # Custom 404 error page
│   ├── template.html  # HTML template for all pages
│   ├── style.css      # Website styling
│   └── imgs/          # Images and icons
└── build/             # Generated website for local preview (git-ignored)
```

## Prerequisites

### Install Pandoc

**macOS:**
```bash
brew install pandoc
```

**Linux (Ubuntu/Debian):**
```bash
sudo apt-get update
sudo apt-get install pandoc
```

**Linux (other distributions):**
Download from [Pandoc releases](https://github.com/jgm/pandoc/releases):
```bash
wget https://github.com/jgm/pandoc/releases/download/3.1.11/pandoc-3.1.11-1-amd64.deb
sudo dpkg -i pandoc-3.1.11-1-amd64.deb
```

**Windows:**
Download the installer from [pandoc.org](https://pandoc.org/installing.html)

### Verify Installation
```bash
pandoc --version
```

## Local Development

### Build the Website
```bash
make build
```
This converts all `.md` files in `src/` to HTML and copies assets to `build/`.

### Preview Locally
```bash
make serve
```
This builds the website and starts a local server at `http://localhost:8000`.

Open your browser and navigate to:
- Homepage: `http://localhost:8000/index.html`
- Papers: `http://localhost:8000/papers.html`
- People: `http://localhost:8000/people.html`

Press `Ctrl+C` to stop the server.

### Clean Build Directory
```bash
make clean
```
Removes all generated files from `build/`.

## Editing Content

### Adding/Editing Pages

1. Edit the markdown files in `src/`:
   - `index.md` - Homepage with bio section
   - `papers.md` - Publications list
   - `people.md` - Team members

2. Save your changes

3. Run `make serve` to preview

### Adding Images

Place images in `src/imgs/` and reference them in markdown:
```markdown
![Alt text](imgs/image.jpg)
```

### Styling

Edit `src/style.css` to change the website's appearance. Changes take effect on next build.

## Publishing to GitHub Pages

### First-Time Setup

1. **Enable GitHub Pages**:
   - Go to repository Settings → Pages
   - Source: "Deploy from a branch"
   - Branch: `gh-pages`, folder: `/ (root)`
   - Click Save

Your site will be available at:
- Organization site: `https://orgname.github.io/` (if repo is named `orgname.github.io`)
- Project site: `https://orgname.github.io/repo-name/` (for other repo names)

### Publishing Updates

To publish changes to the website:

1. **Edit content** in `src/` files

2. **Test locally**:
   ```bash
   make serve
   ```

3. **Commit changes**:
   ```bash
   git add .
   git commit -m "Describe your changes"
   ```

4. **Push to GitHub**:
   ```bash
   git push
   ```

The website is automatically deployed via GitHub Actions. Changes appear online within 1-2 minutes. You can monitor deployment progress in the "Actions" tab of your GitHub repository.

## Troubleshooting

### "command not found: pandoc"
Install Pandoc following the instructions in Prerequisites section.

### "Address already in use" when running `make serve`
Another process is using port 8000. Either stop that process or change the port:
```bash
cd build && python3 -m http.server 8080
```

### Changes not showing on GitHub Pages
- Wait 1-2 minutes for GitHub Actions to complete the deployment
- Hard refresh your browser (Ctrl+Shift+R or Cmd+Shift+R)
- Check the Actions tab on GitHub for deployment status

### Broken links or missing CSS on GitHub Pages
If your repo is NOT named `orgname.github.io`, you may need to update paths in `src/template.html`:
```html
<link rel="stylesheet" href="/repo-name/style.css" />
```

## Make Commands Reference

- `make build` - Build the website
- `make serve` - Build and serve locally at http://localhost:8000
- `make clean` - Remove all built files
- `make help` - Show available commands
