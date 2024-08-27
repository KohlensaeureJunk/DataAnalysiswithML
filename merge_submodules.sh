# Loop over each submodule
for submodule in $(git config --file .gitmodules --name-only --get-regexp path | sed 's/.path$//'); do
    # Get the path and URL of the submodule
    path=$(git config --file .gitmodules --get $submodule.path)
    url=$(git config --file .gitmodules --get $submodule.url)

    # Deinitialize the submodule
    git submodule deinit -f -- "$path"

    # Remove the submodule from the repository
    git rm -f "$path"
    rm -rf ".git/modules/$path"

    # Add the submodule as a remote
    git remote add "$submodule" "$url"

    # Fetch the submodule's history
    git fetch "$submodule"

    # Create a branch from the submodule's main branch (or master)
    git checkout -b "${submodule}_branch" "$submodule/main" || git checkout -b "${submodule}_branch" "$submodule/master"

    # Move the submodule's files to the appropriate directory
    mkdir -p "$path"
    git mv * "$path/" || echo "No files to move for $submodule"

    # Commit the changes
    git commit -m "Merged $submodule into main repository"

    # Switch back to the main branch
    git checkout main

    # Merge the submodule branch into the main branch
    git merge --allow-unrelated-histories "${submodule}_branch"

    # Remove the submodule's remote
    git remote remove "$submodule"
done
