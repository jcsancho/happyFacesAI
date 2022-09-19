# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
alias clientisa='cd /Users/jcsancho/Documents/clientisa'
alias aws2='ssh -i /Users/jcsancho/.ssh/napoleonx.pem ubuntu@ec2-35-180-109-92.eu-west-3.compute.amazonaws.com'
#copy the id_rsa.pub using copy and paste from one terminal to another 
alias workon='source  ~/Dropbox/cryptos/venv/bin/activate'
alias subl='/Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl'

########### SUMMARY COMMANDS  #####################

alias help='echo "list of commands";
	    echo "tr => move to Trash";
	    echo "r => run command";
	    echo "s => send to cryptoserver";
	    echo "restart => restart remote pm2 process";
	    echo "list => list pm2 remote processes";
	    echo "gitpush =>  gitpush ";
	    echo "status => get status pm2 remote processes";
	    echo "delete => delete remote process";
	    echo "postbull => account MetaBull send tweets and restart autopost to read the tweets";
	    echo "postgames => account MetaGames send tweets and restart autopost to read the tweets";
	    echo "postsocial1 => account SocialGuru1 send tweets and restart autopost to read the tweets";
	    echo "stop => stop process";
	    echo "start => restart stopped process";
	    echo "get => get file from server";
	    echo "temperature => get temperature";
	    echo "findlastweek => find files modified last week ";
	    echo "npmupdate => update npm  ";
	    echo "env =>  activate the virtual environment python3.8 ";
	    echo "updatevolume => send marketcap.log and update ";
' 
########### COMMANDS #####################

function updatevolume()  { echo "copying marketcap_strategy_vol.log";
                      scp "./marketcap_strategy_vol.log" jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver;
                      ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 reload volume";
}

function npmupdate() {npm install -g npm@latest; }
function env() {source venv/bin/activate;}
function tr() { mv "$@" ~/.Trash; }
function x()  { ./run "$@"; }
function temperature()  { sudo powermetrics --samplers smc |grep -i "CPU die temperature"; }

function findlastweek()  { find . -mtime -7; }
function gitpush()  { echo "copying profile";
                      cp ~/.profile profile;
                      git add -A;
                      git commit -m "changes";
                      git push; }
function s()  { scp "./$@" jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver; }
function get()  { scp jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver/"$@" .; }
function geti()  { scp /Users/jcsancho/Downloads/"$@".* /Users/jcsancho/Documents/cryptos/twitter_images; 
                   ls -lrt twitter_images; }

function postbull() {
today=$(date +%d_%m_%y);
echo "./tweets_history/"$today".py";
scp tweets_MetaBullWorld.py  "./tweets_history_metabull/"$today".py";
scp tweets_MetaBullWorld.py  jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver;
./copy_imgs.sh
ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 reload postBull";
python3.8 ./twitter_checksize_metabull.py;
#rm -f ./twitter_images/*;
}

function postgames() {
today=$(date +%d_%m_%y);
echo "./tweets_history/"$today".py";
scp tweets_MetaGamesPro.py  "./tweets_history_metagames/"$today".py";
scp tweets_MetaGamesPro.py  jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver;
./copy_imgs.sh
ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 reload postGames";
python3.8 ./twitter_checksize_metagames.py;
#rm -f ./twitter_images/*;
}

function postsocial1() {
today=$(date +%d_%m_%y);
echo "./tweets_history/"$today".py";
scp tweets_socialguru1.py  "./tweets_history_socialguru1/"$today".py";
scp tweets_socialguru1.py  jcsancho@163.172.187.121:/home/jcsancho/tradingviewserver;
./copy_imgs.sh
ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 reload postsocial1";
python3.8 ./twitter_checksize_socialguru1.py;
}

function restart() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 reload $@";}
function stop() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 stop $@";}
function start() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 start $@";}
function list() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 list";}
function status() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 log  $@";}
function delete() {ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "/home/jcsancho/.nvm/versions/node/v9.4.0/bin/pm2 delete  $@";}
function save() { ./gitpush.sh; }

########### COMANDS ANALYSIS #############

alias marketcapview='/Users/jcsancho/Documents/cryptos/analyse_marketcap.sh view "$@" '

alias marketcapget='/Users/jcsancho/Documents/cryptos/analyse_marketcap.sh get ;'

alias marketcap='ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "tail -n 200 /home/jcsancho/data/logs/marketcap.log"'
alias mintingnow='ssh -R 52698:localhost:52698  jcsancho@163.172.187.121 "tail -n 200 /home/jcsancho/data/logs/mintingNFT.log"'

alias whales='ssh    -R 52698:localhost:52698  jcsancho@163.172.187.121 "tail -n 50 /home/jcsancho/data/logs/whalealerts.log"'

########### DIRECTORIES #############
alias caveman='cd /Users/jcsancho/Documents/TheBoredCavemanClub'
alias onedrive='cd /Users/jcsancho/Onedrive'
alias cryptos='cd /Users/jcsancho/Documents/cryptos'
alias best='cd /Users/jcsancho/Documents/besthotelscheap'
alias tiempo='cd /Users/jcsancho/Documents/tiempolaboral'
alias meta='cd /Users/jcsancho/Documents/MetaBullWorld'
alias nft='cd /Users/jcsancho/Documents/NFT'
alias defi='cd /Users/jcsancho/Documents/DeFi'
alias master='cd /Users/jcsancho/Documents/MasterUniversity'


########### SERVERS #############
alias cryptoserver='ssh    -R 52698:localhost:52698  jcsancho@163.172.187.121'
alias deepcryptos='ssh -o "ServerAliveInterval 60" -o "ServerAliveCountMax 120"   jcsancho@51.15.208.39'
alias tiempolaboral='ssh 51.158.74.50'
alias aws='ssh ubuntu@ec2-35-180-109-92.eu-west-3.compute.amazonaws.com'
###################################

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
#shopt -s checkwinsize

# some more ls aliases
alias ll='ls -thrlG '
alias la='ls -A'
alias l='ls -CFG'
alias vd='ls -rtl $1 && cd $1'
alias p='pushd'
alias pp='popd'
alias pl='dirs -v'

lsfind(){
  # local variable x and y with passed args
  local x=$1
  find ./ -name "${x}" -exec ls -l {} \;
}

#jcsancho stuff:

export PATH=$PATH:/Users/jcsancho/bin

# Setting PATH for Python 3.8
# The original version is saved in .profile.pysave
PATH="/Library/Frameworks/Python.framework/Versions/3.8/bin:${PATH}"
export PATH=~/.npm-global/bin:$PATH

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm

# For npm problems with webpack in theboredcavemanclub

# OPENAI: 
export OPENAI_API_KEY=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
