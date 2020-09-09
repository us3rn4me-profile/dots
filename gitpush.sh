echo Adding files to git story
# cp ~/.config/{konsolerc,kwinrc,kwalletrc,kded5rc,nvim,neofetch,htop}
git add ./
git status
sleep 1
echo write message for commit
read message
git commit -am "$message"
echo push?
read yon
if [[ $yon = 'y' || $yon = 'Y' ]]; then
  cat .somecode_us3rn4me-profile | xclip -selection clipboard && echo 'somecode copied!'
  git push origin master
fi
