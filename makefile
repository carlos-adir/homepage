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

repo:
	# This should be run only once, when the OS boots at first time |\
	echo Branch: ${BRANCH}
	echo Git repo: ${GIT_REPO}
	echo Destiny: ${WORK_DIR}
	git clone -b ${BRANCH} --depth 1 --single-branch ${GIT_REPO} ${WORK_DIR}
	cd ${WORK_DIR} && pnpm install --max-old-space-size=512

clean:
	rm -rf ${WORK_DIR}
