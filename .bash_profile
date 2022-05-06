# setup git autocomplete
source ~/.git-completion.bash
source ~/.git-prompt.sh

# Add fastlane into our PATH
export PATH="$HOME/.fastlane/bin:$PATH"
export PATH="/usr/local/sbin:$PATH"

export DANGER_GITHUB_API_TOKEN='e57530e24daab397c79364698329be7b62a46f7f'

# Add mergepbx into PATH
export PATH="~/.mergepbx:$PATH"

# Setup for rbenv
eval "$(rbenv init -)"

# nvm setup (when installed via Homebrew)
export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion" ] && . "/usr/local/opt/nvm/etc/bash_completion"  # This loads nvm bash_completion

# use Sublime as the default editor
export EDITOR="subl -w"

# display the git branch on the commandline
parse_git_branch() {
  git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/ (\1)/'
}

export PS1="\W\[\033[32m\]\$(parse_git_branch)\[\033[00m\] $ "

# helper for finding external IP address
function whatsMyIP() {
  curl ipecho.net/plain; echo
}

function stop() {
  pid=$(lsof -ti tcp:"$1")
  if [[ $pid ]]; then
    kill -9 $pid
  fi
}

# start recording the current iOS simulator
function recordSim() {
  xcrun simctl io booted recordVideo ~/Desktop/simulatorRecording.mov -f
}

# open a URL in the current iOS simulator
function simOpen() {
  xcrun simctl openurl booted $1
}

# show compile time stats for each .swift file
function swifttime() {
  xcodebuild -workspace "$1.xcworkspace" -scheme "$1" clean build OTHER_SWIFT_FLAGS="-Xfrontend -debug-time-function-bodies" | grep [1-9].[0-9]ms | sort -n
}

# remove all merged git branches
function deleteMergedBranches() {
   git branch --merged | grep -v \* | xargs git branch -D 
}

# remove all branches (apart from the current one)
function deleteAllBranches() {
   git branch | grep -v \* | xargs git branch -D 
}

# quickly open all conflicted files in the default editor
function fix() {
	git diff --name-only | uniq | xargs $EDITOR
}

# convert a video into a .gif
function gifme() {
  ffmpeg -i $1 -vf scale=360:-1 -r 20 $1.gif
}

# Generate some lorem Ipsum
function ipsum() {
  if [ $# -eq 2 ] || [ $# -eq 3 ]; then
    OK=0
    if [ "$1" = "-w" ]; then
        LOREM_TYPE="words"
        OK=1
    fi
    if [ "$1" = "-p" ]; then
        LOREM_TYPE="paras"
        OK=1
    fi
    if [ "$1" = "-b" ]; then
        LOREM_TYPE="bytes"
        OK=1
    fi
    AMOUNT=$2
    START="yes"
    if [ $# -eq 3 ] && [ "$3"="-n" ]; then
        START="no"
    fi
    if [ $OK -eq 1 ]; then
        RAW_LIPSUM=$(curl -fsSkL "http://www.lipsum.com/feed/xml?amount=$AMOUNT&what=$LOREM_TYPE&start=$START")
        #delete before lipsum
        LIPSUM=${RAW_LIPSUM#*<lipsum>}
        #delete after lipsum
        LIPSUM=${LIPSUM%</lipsum>*}
        echo "$LIPSUM"
    fi
else
    echo 'Usage: lorem_ipsum [-w|-p|-b] N [-n M]'
    echo '  where'
    echo '  N is an integer indicating the number of words/paragraphs/bytes'
    echo '  M can be yes or no which indicates whether the generated word/paragraph/byte starts with "Lorem ipsum ..." It is optional and default value is yes.'
    echo '  '
    echo 'Examples:'
    echo 'lorem_ipsum -p 3'
    echo 'Generates 3 paragraphs of lorem ipsum.'
    echo '  '
    echo 'lorem_ipsum -p 3 -n no'
    echo 'Generates 3 paragraphs of lorem ipsum which doesnt start with "Lorem ipsum ..."'
    echo '  '
    echo 'lorem_ipsum -w 10'
    echo 'Generates 10 words of lorem ipsum.'
    echo '  '
    echo 'lorem_ipsum -b 64'
    echo 'Generates 64 bytes of lorem ipsum.'
    echo '  '
    echo 'Credits:'
    echo 'The lorem_ipsum script is written by Dogukan Cagatay (http://github.com/dogukancagatay)'
    echo 'The Lorem Ipsum extract taken from http://www.lipsum.com/ courtesy of James Wilson'

fi
}

# Regenrate the project files
function gp() {
  # Kill xcode
  kill $(ps aux | grep 'Xcode' | awk '{print $2}')

  # Generate project files and workspace
  ./scripts/GenerateProject.command

  # Open newly generated workspace
  open ./Wise.xcworkspace
}

function fixAudio() {
    sudo kill -9 `ps ax|grep 'coreaudio[a-z]' | awk '{print $1}'`
}

function rebaseDev() {
  git fetch upstream dev
  git rebase upstream/dev
}

function toDev() {
  git checkout dev
  git pull upstream dev
}

function svgToPDF() {
  qlmanage -t -s 1000 -o . $1
}

function dockerStopAll() {
  docker stop $(docker ps -a -q)
}

function wiseDataContainer() {
  xcrun simctl get_app_container booted com.transferwise.Transferwise data
}
