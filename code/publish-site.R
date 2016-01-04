#!/usr/bin/env Rscript

library("git2r")

repo <- repository(".", discover = TRUE)

# http://stackoverflow.com/a/12142066
current_branch <- system("git rev-parse --abbrev-ref HEAD", intern = TRUE)

if (current_branch != "gh-pages") {
  checkout(repo, "gh-pages")
  merge(repo, "gh-pages")
}

system("make -i")

add(repo, "*html", force = TRUE)
add(repo, "./figure/*", force = TRUE)
add(repo, "./libs/*", force = TRUE)
commit(repo, message = "Build site.")
# Currently does not work
# https://github.com/ropensci/git2r/issues/140
push(repo, name = "origin", refspec = "refs/heads/gh-pages")

if (current_branch != "gh-pages") {
  checkout(repo, current_branch)
}
