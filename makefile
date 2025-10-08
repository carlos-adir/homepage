.SILENT:
HOSTS = "*"
HOME_DIR?=${shell cd ~ && pwd}
GIT_DIR=${HOME_DIR}/git
WORK_DIR=${GIT_DIR}/test/gethomepage
GIT_REPO="https://github.com/gethomepage/homepage.git"
BRANCH="main"

start:
	HOMEPAGE_ALLOWED_HOSTS=${HOSTS} pnpm start &

build:
	# This should be run when an big update happens
	pnpm build

stop:
	echo "Stop"
	echo ${HOSTS}
	echo ${HOME_DIR}
	echo ${GIT_DIR}

setup: update gitrepo

update:
	echo "Updating system..."
	apt-get update
	apt-get upgrade

packages:
	echo "Installing basic packages..."
	apt-get update
	apt-get upgrade
	apt-get install npm
	npm install -g pnpm

gitrepo:
	# This should be run only once, when the OS boots at first time
	echo Branch: ${BRANCH}
	echo Git repo: ${GIT_REPO}
	echo Destiny: ${WORK_DIR}
	git clone -b ${BRANCH} --depth 1 --single-branch ${GIT_REPO} ${WORK_DIR}
	pnpm install --max-old-space-size=512
	echo 'HOMEPAGE_ALLOWED_HOSTS="*"' >> /etc/environment
	Comment |\

clean:
	rm -rf homepage