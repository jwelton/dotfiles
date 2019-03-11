# setup git autocomplete
source ~/.git-completion.bash
source ~/.git-prompt.sh

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

# start recording the current iOS simulator
function recordSim() {
  xcrun simctl io booted recordVideo ~/Desktop/simulatorRecording.mov
}

# open a URL in the current iOS simulator
function simOpenURL() {
  xcrun simctl openurl booted $0
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

# convert a video into a .gif
function gifme() {
  ffmpeg -i $1 -vf scale=360:-1 -r 20 $1.gif
}