#!/usr/bin/bash

prefix="open-sci-template:"

# http://stackoverflow.com/a/12142066
starting_branch=`git rev-parse --abbrev-ref HEAD`
echo -e "$prefix On branch $starting_branch"

if [ $starting_branch != "gh-pages" ]
then
  echo -e "$prefix Switching to branch gh-pages"
  git checkout gh-pages
  echo -e "$prefix Merging branch $starting_branch into gh-pages"
  git merge --no-edit $starting_branch
fi

echo -e "$prefix Building site. Check file log.txt for progress"
make -i &> log.txt

echo -e "$prefix Adding html files, figures, and log.txt"
git add -f *html
git add -f figure/*
git add -f log.txt
echo -e "$prefix Committing"
git commit -m "Build site."

echo -e "$prefix Pushing to gh-pages branch"
git push origin gh-pages

if [ $starting_branch != "gh-pages" ]
then
  echo -e "$prefix Returning to branch $starting_branch"
  git checkout $starting_branch
fi
