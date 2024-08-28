for submodule in $(git config --file .gitmodules --name-only --get-regexp path | sed 's/.path$//'); do
    # Get the path and URL of the submodule
    path=$(git config --file .gitmodules --get $submodule.path)
    url=$(git config --file .gitmodules --get $submodule.url)
    echo $submodule
    echo $path
    echo $url
done
