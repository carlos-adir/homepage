.SILENT:
HOSTS = "*"
HOME_DIR?=${shell cd ~ && pwd}
GIT_DIR=${HOME_DIR}/git
WORK_DIR=${GIT_DIR}/gethomepage
GIT_REPO="https://github.com/gethomepage/homepage.git"
BRANCH="main"
SYS_DIR=${HOME_DIR}/.config/systemd/user

start:
	cd ${WORK_DIR} && HOMEPAGE_ALLOWED_HOSTS=${HOSTS} pnpm start &

build:
	# This should be run when an big update happens
	cd ${WORK_DIR} && pnpm build

stop:
	echo "Stop"
	echo ${HOSTS}
	echo ${HOME_DIR}
	echo ${GIT_DIR}

setup: update afterboot packages gitrepo build

update:
	echo "Updating system..."
	apt-get update
	apt-get upgrade

afterboot:
	echo "Setting files after boot"
	cp git-pull.service ${SYS_DIR}
	cp make-start ${SYS_DIR}
	systemctl --user enable git-pull.service
	systemctl --user enable make-start.service

packages:
	echo "Installing basic packages..."
	apt-get update
	apt-get upgrade
	apt-get install git
	apt-get install npm
	npm install -g pnpm

gitrepo:
	# This should be run only once, when the OS boots at first time |\
	echo Branch: ${BRANCH}
	echo Git repo: ${GIT_REPO}
	echo Destiny: ${WORK_DIR}
	git clone -b ${BRANCH} --depth 1 --single-branch ${GIT_REPO} ${WORK_DIR}
	cd ${WORK_DIR} && pnpm install --max-old-space-size=512

clean:
	rm -rf ${WORK_DIR}
