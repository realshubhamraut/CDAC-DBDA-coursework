# what is git and version control
Git is a distributed version control system that tracks changes in files over time. Version control allows multiple developers to collaborate, maintain history of changes, revert to previous versions, and manage different code branches safely.


# what is the role of github here

1. GitHub is a cloud-based hosting platform for Git repositories.
2. It provides remote storage, collaboration tools (pull requests, issues), code review features, and facilitates team workflows.
3. GitHub acts as the central hub where developers push/pull code and collaborate on projects.
other options are GitLab and BitBucket, but popular is github





git config --global user.name "Your Name"
git config --global user.email "your.email@example.com"

git init


git clone <repository-url>
git status
git diff

git add <filename>

git add .

git commit -m "Your commit message"

# View commit history
git log

# View compact history
git log --oneline

# View last N commits
git log -n 5


# List all branches
git branch

# Create new branch
git branch <branch-name>

# Switch to branch
git checkout <branch-name>

# Create and switch to new branch
git checkout -b <branch-name>

# Merge branch into current branch
git merge <branch-name>

# Delete branch
git branch -d <branch-name>



# Add remote repository
git remote add origin <repository-url>

# View remote repositories
git remote -v

# Push to remote repository
git push origin <branch-name>

# Push and set upstream
git push -u origin main

# Pull latest changes
git pull origin <branch-name>

# Fetch changes without merging
git fetch


# 1. Clone repository
git clone https://github.com/username/repo.git
cd repo

# 2. Create feature branch
git checkout -b feature-branch

# 3. Make changes and commit
git add .
git commit -m "Add new feature"

# 4. Push to remote
git push -u origin feature-branch

# 5. Merge to main (after approval)
git checkout main
git merge feature-branch
git push origin main
