for submodule in $(git config --file .gitmodules --name-only --get-regexp path | sed 's/.path$//'); do
    # Get the path and URL of the submodule
    path=$(git config --file .gitmodules --get $submodule.path)
    url=$(git config --file .gitmodules --get $submodule.url)

    # Deinitialize the submodule
    git submodule deinit -f -- $path

    # Remove the submodule from the repository
    git rm -f $path
    rm -rf .git/modules/$path
    git commit -m "removed ${submodule}"

    # Add the submodule as a remote
    git remote add $path $url

    # Fetch the submodule's history
    git fetch $path

    # Create a branch from the submodule's main branch
    git checkout -b "${path}_branch" $path/main

    # Move the submodule's files to the appropriate directory
    cont=$(ls .)
    mkdir -p $path
    git mv $cont $path

    # Commit the changes.
    echo "Committing to temporary branch"
    git commit -m "Merged ${path} into main repository"

    # Switch back to the main branch
    git checkout master
    echo "Merging branches"

    # Merge the submodule branch into the main branch
    git merge --allow-unrelated-histories "${path}_branch" -m "merge ${path}"

    # Remove the submodule's remote
    git remote remove $path

    # Remove the temporary branch
    git branch -D "${path}_branch"

done
